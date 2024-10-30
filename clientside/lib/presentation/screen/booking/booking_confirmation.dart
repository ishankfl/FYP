// Method to show the confirmation dialog
import 'package:bookme/constant/colors.dart';
import 'package:bookme/constant/server.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../widget/custom_elevated_button.dart';

void showConfirmationDialog(
  BuildContext context,
  UserModel user,
  DateTime selectedDate,
  TimeOfDay selectedTime,
  ServiceProviderModel model,
) async {
  showDialog(
    // barrierColor: ColorConstant.prmary_color_notdart(),
    // barrierLabel: ,
    context: context,
    builder: (BuildContext context) {
      var stateDate = context.watch<DateCubit>().state.date;
      var stateTime = context.read<TimeCubit>().state.time;
      int year;
      int month;
      int day;
      int hour;
      int minute;

      if (stateDate != null) {
        year = stateDate.year;
        month = stateDate.month;
        day = stateDate.day;
      } else {
        year = selectedDate.year;
        month = selectedDate.month;
        day = selectedDate.day;
      }

      if (stateTime != null) {
        hour = stateTime.hour;
        minute = stateTime.minute;
      } else {
        hour = selectedTime.hour;
        minute = selectedTime.minute;
      }
      int expectedHours =
          context.watch<ExpectedHoursCubit>().state.expectedHours;

      return AlertDialog(
        backgroundColor: ColorConstant.prmary_color_notdart(),
        title: TextFieldLabel(
            text: "Are you sure to booking ?",
            colorr: ColorConstant.primary_color_dark(),
            fontsize: 20,
            padding: const EdgeInsets.all(0)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldLabel(
                text: "Provider Details",
                colorr: ColorConstant.primary_color_dark(),
                fontsize: 15,
                padding: const EdgeInsets.all(0)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldLabel(
                          text: "Name:   ${model.user!.full_name}",
                          colorr: ColorConstant.primary_color_dark(),
                          fontsize: 10,
                          padding: const EdgeInsets.all(0)),
                      Row(
                        children: [
                          TextFieldLabel(
                              text: "Phone:  ${model.user!.phonenumber} ",
                              colorr: ColorConstant.primary_color_dark(),
                              fontsize: 10,
                              padding: const EdgeInsets.all(0)),
                          GestureDetector(
                            onTap: () async {
                              try {
                                var number =
                                    // model
                                    '${model.user?.phonenumber}'; //set the number here

                                await FlutterPhoneDirectCaller.callNumber(
                                    number);
                              } catch (e) {
                                print(e);
                              }
                              // ignore: prefer_interpolation_to_compose_strings
                            },
                            child: const Card(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.call,
                                  size: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                        child: CustomImage(
                      width: 50,
                      height: 50,
                      imagepath: model.user!.profile.toString(),
                    )),
                  )
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            TextFieldLabel(
                text: "Your Details",
                colorr: ColorConstant.primary_color_dark(),
                fontsize: 15,
                padding: const EdgeInsets.all(0)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldLabel(
                          text: "Fullname:   ${user.full_name}",
                          colorr: ColorConstant.primary_color_dark(),
                          fontsize: 13,
                          padding: const EdgeInsets.all(5)),
                      TextFieldLabel(
                          text:
                              "Bookin Date and time:  $year-$month-$day $hour:$minute",
                          colorr: ColorConstant.primary_color_dark(),
                          fontsize: 13,
                          padding: const EdgeInsets.all(5)),
                      TextFieldLabel(
                          text: "Expedted Hours:   $expectedHours",
                          colorr: ColorConstant.primary_color_dark(),
                          fontsize: 13,
                          padding: const EdgeInsets.all(5)),
                     
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: "Confirm",
              radiusinput: 40,
              width: 130,
              height: 50,
              onPressed: () {
                String service = "${model.services_offered!}";
                String provider = "${model.id}";

                String startDateTime = "$year-$month-$day $hour:$minute";
                String token = getAccessToken(context);
                LocationState state = context.read<LocationCubit>().state;
                String location = '';
                double lon = 0;
                double lat = 0;

                try {
                  if (state is LocationLoaded) {
                    location = state.location;
                    lon = state.lonlag[0];
                    lat = state.lonlag[1];

                    context.read<BookingBloc>().add(BookingClickedEvent(
                        address: location,
                        service: service,
                        provider: provider,
                        start_date_time: "$startDateTime:00",
                        expectedHours: "$expectedHours",
                        longitude: "$lon",
                        latitude: "$lat",
                        token: token,
                        location: location));
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
