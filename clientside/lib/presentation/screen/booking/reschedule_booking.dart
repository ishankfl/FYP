// ignore_for_file: avoid_print

import 'package:bookme/constant/colors.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/expected_time_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

import '../../../logic/services/stringtodate.dart';

void showPopup(BuildContext context,
    {required ServiceProviderModel model, required BookModel bookModel}) {
  // context.read<LocationCubit>().showAddress();
  DateTime date = StringToDate(bookModel.booking_start_date_time!);
  context.read<DateCubit>().addition(date: date);
  context
      .read<TimeCubit>()
      .addition(time: TimeOfDay(hour: date.hour, minute: date.minute));

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: const EdgeInsets.all(0),
        insetPadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.all(0),
        title:  TextFieldLabel(text:'Reschedule time',padding: EdgeInsets.only(left: 20,top: 15),fontsize: 20),
        titlePadding: const EdgeInsets.only(top: 0, left: 0),
        backgroundColor: ColorConstant.prmary_color_notdart(),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          height: 360,
          child: Center(
            child: Column(
              children: [
                TextFieldLabel(
                    padding: EdgeInsets.all(20),
                    text:
                        "Start Date: ${date.year}-${date.month}-${date.day} "),
                TextFieldLabel(
                  padding: EdgeInsets.only(left: 20),
                    text: "Expected Hours: ${bookModel.expected_hour}"),
                SizedBox(
                  width: 360,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          ExpectedTimeWidget(model: model),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomElevatedButton(
                  width: 200,
                  text: "Save",
                  onPressed: () {
                    DateTime? dateTime = context.read<DateCubit>().state.date;
                    TimeOfDay? time = context.read<TimeCubit>().state.time;
                    String fullDate =
                        "${dateTime!.year}-${dateTime.month}-${dateTime.day} ${time!.hour}:${time.minute}:00";
                    int? expectedHours =
                        context.read<ExpectedHoursCubit>().state.expectedHours;
                    print(dateTime.toString());
                    print(time.toString());
                    print(fullDate);
                    TimeValidationState state =
                        context.read<TimeValidationBloc>().state;
                    if (state is TimeValidationLoadedState) {
                      print("Can re sechdule");
                      print(fullDate);
                      context.read<RescheduleBloc>().add(RescheduleClickedEvent(
                          start_date_time: fullDate,
                          expectedHours: expectedHours.toString(),
                          token: getAccessToken(context),
                          bookId: bookModel.id.toString()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
