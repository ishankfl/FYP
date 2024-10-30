import 'package:bookme/logic/bloc/chart/chart_bloc.dart';
import 'package:bookme/logic/bloc/chart/chart_state.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// class MyBarChart extends StatelessWidget {
// @override
BlocBuilder buildChart(BuildContext context) {
  List<BarChartGroupData> barchar = [];

  return BlocBuilder<ChartBloc, ChartState>(builder: (context, state) {
    if (state is ChartLoaded) {
      for (var data in state.bookModel) {
        var month = data.payment_date__month;
        var income = data.total_income;

        barchar.add(BarChartGroupData(
          x: month!,
          barRods: [BarChartRodData(toY: income!)],
        ));
      }
      print(state.bookModel);
      return Container(
        height: 300,
        child: BarChart(
          BarChartData(
            barGroups: barchar,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                  axisNameWidget: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: const Text("Total income"))),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 1:
                        return const Text("January");
                      case 2:
                        return const Text("February");
                      case 3:
                        return const Text("March");
                      case 4:
                        return const Text("April");
                      case 5:
                        return const Text("May");
                      case 6:
                        return const Text("June");
                      case 7:
                        return const Text("July");
                      case 8:
                        return const Text("August");
                      case 9:
                        return const Text("September");
                      case 10:
                        return const Text("October");
                      case 11:
                        return const Text("November");
                      case 12:
                        return const Text("December");
                      default:
                        return const Text("Invalid Month");
                    }
                  },
                ),
                // showTitles: true,
                // getTitles:
              ),
            ),
          ),
        ),
      );
    }
    if (state is ChartError) {
      return Container(
        height: 1,
      );
    }
    if (state is ChartLoading) {
      return Container(
        height: 1,
      );
    }

    context
        .read<ChartBloc>()
        .add(ChartClickedEvent(token: getAccessToken(context)));

    // if (state is ChartLoading) {
    //   return CircularProgressIndicator();
    // }
    return Container(
      height: 1,
    );
  });
}
