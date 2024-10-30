// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:bookme/constant/colors.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/screen/common/app_bar.dart';
import 'package:bookme/presentation/screen/common/sidebar/side_bar.dart';
import 'package:bookme/presentation/screen/service_providerside/chart_provider.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProviderHome extends StatelessWidget {
  const ProviderHome({super.key});

  // String get accesstoken => 'null';
  @override
  Widget build(BuildContext context) {
    String accesstoken = getAccessToken(context);

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const SideBar(),
      appBar: CustomAppBarTop.customAppBar(context),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<FetchRequestCountBloc, FetchRequestCountState>(
                builder: (context, state) {
                  if (state is FetchRequestCountLoadedState) {
                    List requestCount = [
                      {
                        'text': "New Request",
                        "value": state.model[0].new_requests_count.toString()
                      },
                      {
                        'text': "Confirm Request",
                        "value":
                            state.model[0].accepted_requests_count.toString()
                      },
                      {
                        'text': "Completed Request",
                        "value":
                            state.model[0].completed_requests_count.toString()
                      }
                    ];
                    print(state.model[0]);
                    return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 15.0,
                            mainAxisExtent: 120,
                          ),
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: ColorConstant.prmary_color_notdart(),
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment
                                    //     .center, // Vertical centering
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: TextFieldLabel(
                                          text: requestCount[index]['text'],
                                          colorr: ColorConstant
                                              .primary_color_dark(),
                                          fontsize: 15,
                                          padding: const EdgeInsets.all(0),
                                          text_align: TextAlign
                                              .center, // Center align the text
                                        ),
                                      ),
                                      Container(
                                        // padding: EdgeInsets.all(10),
                                        child: TextFieldLabel(
                                          text: requestCount[index]['value'],
                                          colorr: ColorConstant
                                              .primary_color_dark(),
                                          fontsize: 25,
                                          padding: const EdgeInsets.all(0),
                                          alignment: Alignment.center,
                                          text_align: TextAlign
                                              .center, // Center align the text
                                        ),
                                      ),
                                    ],
                                  )),
                              onTap: () {
                                context
                                    .read<ViewRequestPageCubit>()
                                    .pageChange(index: index);
                                Navigator.push(
                                    context,
                                    GeneratedRoute().onGeneratedRoute(
                                        const RouteSettings(
                                            name: '/view_booking')));
                                // Your onTap logic
                              },
                            );
                          },
                        ));
                  }
                  if (state is FetchRequestCountErrorState) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      // alignment: Alignment.center,
                      child: ErrorFetchingData(
                        message: "Please try again",
                        btnName: "Retry",
                        onPressed: () {
                          context.read<FetchRequestCountBloc>().add(
                              FetchRequestCountHit(
                                  token: getAccessToken(context)));
                          context.read<ChartBloc>().add(ChartClickedEvent(
                              token: getAccessToken(context)));
                        },
                      ),
                    );
                  }
                  if (state is FetchRequestCountLoadingState) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: Container(
                              height: 40, child: CircularProgressIndicator())),
                    );
                  }
                  context.read<FetchRequestCountBloc>().add(
                      FetchRequestCountHit(token: getAccessToken(context)));
                  return ErrorFetchingData(
                      message: "Getting error on fetching data",
                      btnName: "Re-try");
                },
              ),
              // Spacer(),
              // Text("income"),
              buildChart(context),
              SizedBox(
                height: 50,
              )
            ]),
      )),
    );
  }
}
