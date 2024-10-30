// ignore: must_be_immutable
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:bookme/constant/colors.dart';
import 'package:bookme/constant/server.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/booking/booking_confirmation.dart';
import 'package:bookme/presentation/screen/booking/service_provider_page.dart';
import 'package:bookme/presentation/screen/booking/view_booking.dart';
import 'package:bookme/presentation/screen/common/home_page.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/presentation/widget/expected_time_widget.dart';
import 'package:bookme/presentation/widget/location_widget.dart';
import 'package:bookme/presentation/widget/user_profile_image_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookingTimeDetails extends StatelessWidget {
  final ServiceProviderModel model;
  BookingTimeDetails({super.key, required this.model});
  UserModel? user;
  String accesstoken = '';

  @override
  Widget build(BuildContext context) {
    accesstoken = getAccessToken(context);

    FetchProfileState state2 = context.watch<FetchProfileBloc>().state;
    if (state2 is FetchProfileLoadedState) {
      user = (state2.userModel);
    }
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
        context.read<DateCubit>().addition(date: selectedDate);
      }
      context.read<DateCubit>().addition(date: selectedDate);
      String fulldate =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}";

      // selectTime(context);
      context.read<TimeValidationBloc>().add(TimeValidationHit(
            token: accesstoken,
            providerId: model.id!,
            expectedHours: context
                .read<ExpectedHoursCubit>()
                .state
                .expectedHours
                .toString(),
            date_time: fulldate,
          ));
    }

    // context.read<LocationCubit>().showAddress();

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked =
          await showTimePicker(context: context, initialTime: selectedTime);
      if (picked != null && picked != selectedTime) {
        selectedTime = picked;
        context.read<TimeCubit>().addition(time: selectedTime);
      }
      String fulldate =
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}";

      // selectTime(context);
      context.read<TimeValidationBloc>().add(TimeValidationHit(
            token: accesstoken,
            providerId: model.id!,
            expectedHours: context
                .read<ExpectedHoursCubit>()
                .state
                .expectedHours
                .toString(),
            date_time: fulldate,
          ));
    }

    TextEditingController expectedHoursController =
        TextEditingController(text: "1");
    BlocListener<ExpectedHoursCubit, ExpectedHoursState>(
        listener: (context, state) {
          expectedHoursController.text = state.expectedHours.toString();
        },
        child: const Text("Hello"));
    BookingState bookingState = context.read<BookingBloc>().state;

    return BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingError) {
            snacbar(context, "Error", "Booking incomplete", false);
          }
          if (state is BookingLoaded) {
            snacbar(context, "Success", "Successfully booking done", true);
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return HomePage();
            }));

            print(bookingState); // context.read<BookingBloc>().state.
            print("Yes loaded");
            print(context.read<BookingBloc>().state);
          }
        },
        child: Scaffold(
          appBar: backBtnAppbar("Booking"),
          body: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Make the photo circular
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileImageCircleAvatar(
                            key: key,
                            profileUrl: model.user!.profile,
                          ),
                          bookingPageProviderLabel(
                              "", '${model.user!.full_name}'),
                        ],
                      ),
                      // const Spacer(),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          bookingPageProviderLabel(
                              "Address :", '${model.user!.city}'),
                          bookingPageProviderLabel(
                              "Phone : ", "${model.user!.phonenumber}"),
                          bookingPageProviderLabel(
                              "Type : ", "${model.user!.user_type}"),
                          bookingPageProviderLabel(
                              "Experience : ", "${model.experience} Years"),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                  // margin: const EdgeInsets.only(top: 4),
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Divider(),

                      ExpectedTimeWidget(model: model),
                      const Divider(),
                      TextFieldLabel(text: "Location", fontsize: 16),
                      // Padding(
                      // padding: const EdgeInsets.only(left: 10, right: 10),
                      InkWell(
                        child: const LocationWidget(),
                        onTap: () {
                          // showMap(context);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldLabel(text: "Enter a details of using service"),
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: const CustomTextFormField(
                          hintText: "Enter details",
                          autofocus: false,
                        ),
                      ),

                      Container(
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomElevatedButton(
                        text: "Book",
                        width: 150,
                        onPressed: () {
                          TimeValidationState state =
                              context.read<TimeValidationBloc>().state;
                          if (state is TimeValidationLoadedState) {
                            showConfirmationDialog(context, user!, selectedDate,
                                selectedTime, model);
                          } else {
                            snacbar(
                                context,
                                "Error",
                                "Please verify booking date time first!",
                                false);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            )),
          ),
        ));
  }

  Row bookingPageProviderLabel(String textt, String data) {
    return Row(
      children: [
        ProviderDetailText(
          text: "$textt",
          weight: FontWeight.w700,
          size: 15,
        ),
        ProviderDetailText(
          text: " $data",
          weight: FontWeight.w600,
          size: 15,
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class VerficationCheckArrow extends StatelessWidget {
  IconData? iconn;
  VerficationCheckArrow({
    required this.iconn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(),
        child: Icon(
          iconn,
          color: Colors.blue,
          size: 25,
        ));
  }
}
