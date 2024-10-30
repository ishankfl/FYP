import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/logic/cubit/expected_hours/expected_hours_cubit.dart';
import 'package:bookme/presentation/screen/booking/booking_page.dart';
import 'package:bookme/presentation/widget/date_time_choosen.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

class ExpectedTimeWidget extends StatelessWidget {
  final ServiceProviderModel model;
  ExpectedTimeWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    bool ignoringpointer = false;

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
            token: getAccessToken(context),
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
            token: getAccessToken(context),
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
    String accessToken = getAccessToken(context);
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            TextFieldLabel(text: "Date & time", fontsize: 16),
            TextFieldLabel(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                text: "(Click to change a date & time)",
                fontsize: 12),
          ],
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DateTimeWidget.DateTimeShowWidget(
                  selectDate, selectedDate, selectTime, selectedTime),
              Container(
                  alignment: Alignment.centerLeft,
                  child: BlocBuilder<TimeValidationBloc, TimeValidationState>(
                      builder: (context, state) {
                    if (state is TimeValidationLoadedState) {
                      ignoringpointer = false;
                      return VerficationCheckArrow(iconn: Icons.verified);
                    }
                    if (state is TimeValidationErrorState) {
                      ignoringpointer = true;

                      return VerficationCheckArrow(iconn: Icons.help_outline);
                    }
                    if (state is TimeValidationLoadingState) {
                      ignoringpointer = true;

                      return const CircularProgressIndicator();
                    }
                    return VerficationCheckArrow(iconn: Icons.help_outline);
                  })),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            TextFieldLabel(
                fontsize: 17, text: "Expected Hours: ", colorr: Colors.black),
            const SizedBox(
              width: 20,
            ),
            InkWell(
                child: const Icon(Icons.remove),
                onTap: () {
                  // print();
                  context.read<ExpectedHoursCubit>().decrement(context);

                  String fulldate =
                      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}";

                  // selectTime(context);
                  context.read<TimeValidationBloc>().add(TimeValidationHit(
                        token: accessToken,
                        providerId: model.id!,
                        expectedHours: expectedHoursController.text,
                        date_time: fulldate,
                      ));
                }),
            BlocBuilder<ExpectedHoursCubit, ExpectedHoursState>(
              builder: (context, state) {
                expectedHoursController.text = state.expectedHours.toString();
                return SizedBox(
                  height: 30,
                  width: 50,
                  child: TextField(
                    controller: expectedHoursController,
                    cursorHeight: 0,
                    textAlign: TextAlign.center,

                    // height: 10,
                  ),
                );
              },
            ),
            InkWell(
                child: const Icon(Icons.add),
                onTap: () {
                  context.read<ExpectedHoursCubit>().increment(context);

                  String fulldate =
                      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day} ${selectedTime.hour}:${selectedTime.minute}";
                  context.read<TimeValidationBloc>().add(TimeValidationHit(
                        token: accessToken,
                        providerId: model.id!,
                        expectedHours: expectedHoursController.text,
                        date_time: fulldate,
                      ));
                  // ExpectedHoursCubit
                }),
          ],
        ),
        // Spacer(),
      ],
    );
  }
}