import 'package:bookme/constant/colors.dart';
import 'package:bookme/logic/cubit/date_time/date_time_cubit.dart';
import 'package:bookme/logic/cubit/date_time/date_time_state.dart';
import 'package:bookme/presentation/widget/add_bid_container_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateTimeWidget {
  static Widget DateTimeShowWidget(
      Future<void> selectDate(BuildContext context),
      DateTime selectedDate,
      Future<void> selectTime(BuildContext context),
      TimeOfDay selectedTime) {
    Row row = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.date_range,
            size: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              BlocBuilder<DateCubit, DateState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      selectDate(context).toString();
                      return;
                    },
                    child: TextFieldLabel(
                        fontsize: 17,
                        padding: EdgeInsets.all(0),
                        text: state.date != null
                            ? "${state.date!.year}/${state.date!.month}/${state.date!.day} "
                            : "${selectedDate.year}/${selectedDate.month}/${selectedDate.day} "),
                  );
                },
              ),
              const SizedBox(
                width: 20,
              ),

              const Icon(
                Icons.timer,
                size: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              // Using Container with BoxDecoration for date input
              BlocBuilder<TimeCubit, TimeState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () => selectTime(context),
                    child: TextFieldLabel(
                        fontsize: 17,
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        text: state.time != null
                            ? " ${state.time!.hour}:${state.time!.minute}"
                            : " ${selectedTime.hour}:${selectedTime.minute}"),
                  );
                },
              ),
            ],
          ),
          const SizedBox(
            width: 40,
          )
        ]);

    return CustomeContainerBid.CustomContainer(row);
  }
}
