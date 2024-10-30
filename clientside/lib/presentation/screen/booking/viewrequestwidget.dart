import 'package:bookme/constant/colors.dart';
import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/logic/cubit/location/location_focus_cubit.dart';
import 'package:bookme/logic/services/stringtodate.dart';
import 'package:bookme/presentation/screen/booking/reschedule_booking.dart';
import 'package:bookme/presentation/screen/booking/review_rate_booking.dart';
import 'package:bookme/presentation/screen/booking/view_booking_details.dart';
import 'package:bookme/presentation/screen/chat/messaging_page.dart';
import 'package:bookme/presentation/screen/payment/khalti_page.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/presentation/widget/show_mapview_dialog.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class ViewRequestWidget extends StatelessWidget {
  List<List<String>> btns;
  ViewRequestWidget({super.key, required this.btns});

  @override
  Widget build(BuildContext context) {
    List<BookModel> model = [];

    String token = getAccessToken(context);

    return DefaultTabController(
        length: 3,
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: (2).toInt()));
          },
          child: Scaffold(
            body: BlocBuilder<FetchBookingBloc, FetchBookingState>(
              builder: (context, state) {
                if (state is FetchBookingLoaded) {
                  List<BookModel> getFilteredModel(String status) {
                    model = state.bookModel!;
                    return model.where((booking) {
                      return (booking.status == status);
                    }).toList();
                  }

                  if (state is FetchBookingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is FetchBookingEmpty) {
                    return Text("is empty");
                  }

                  return BlocBuilder<FetchBookingBloc, FetchBookingState>(
                    builder: (context, state) {
                      print(state);
                      if (state is FetchBookingLoaded) {
                        return TabBarView(children: [
                          Tab(
                            child: BookingView(
                                model: getFilteredModel('confirmed'),
                                btn: btns[0]),
                          ),
                          Tab(
                            child: BookingView(
                                model: getFilteredModel('pending'),
                                btn: btns[1]),
                          ),
                          Tab(
                            child: BookingView(
                                model: getFilteredModel('completed'),
                                btn: btns[2]),
                          ),
                        ]);
                      }
                      if (state is FetchBookingError) {
                        return ErrorFetchingData(
                            message: state.message!,
                            btnName: "Try again",
                            onPressed: () {
                              context.read<FetchBookingBloc>().add(
                                  FetchBookingDetailsClickedEvent(
                                      token: token));
                            });
                      }
                      if (state is FetchBookingLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is FetchBookingEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      context
                          .read<FetchBookingBloc>()
                          .add(FetchBookingDetailsClickedEvent(token: token));
                      return ErrorFetchingData(
                        message: "Try again",
                        btnName: "Retry",
                        onPressed: () {
                          context.read<FetchBookingBloc>().add(
                              FetchBookingDetailsClickedEvent(token: token));
                        },
                      );
                    },
                  );
                }
                if (state is FetchBookingError) {
                  return ErrorFetchingData(
                      message: state.message!,
                      btnName: "Try again",
                      onPressed: () {
                        context
                            .read<FetchBookingBloc>()
                            .add(FetchBookingDetailsClickedEvent(token: token));
                      });
                }
                if (state is FetchBookingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FetchBookingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                context
                    .read<FetchBookingBloc>()
                    .add(FetchBookingDetailsClickedEvent(token: token));
                return ErrorFetchingData(
                  message: "Try again",
                  btnName: "Retry",
                  onPressed: () {
                    context
                        .read<FetchBookingBloc>()
                        .add(FetchBookingDetailsClickedEvent(token: token));
                  },
                );
              },
            ),
            appBar: backBtnAppbar(
              "My Bookings",
              bottonBar: TabBar(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(0, 94, 112, 213)),
                  labelColor: ColorConstant.prmary_color_notdart(),
                  padding: const EdgeInsets.only(bottom: 10),
                  onTap: (values) {
                    // //print(values);
                  },
                  indicator: BoxDecoration(
                      color: ColorConstant.secondary_color_blue(),
                      borderRadius: BorderRadius.circular(30)),
                  indicatorPadding:
                      const EdgeInsets.only(left: -15, right: -15),
                  dividerHeight: 0,
                  tabs: [
                    Tab(
                        icon: const Icon(
                          Icons.approval,
                          color: Colors.white,
                        ),
                        child: TextFieldLabel(
                            alignment: Alignment.center,
                            text: "Accepted",
                            colorr: Colors.white,
                            padding: const EdgeInsets.all(0))),
                    Tab(
                        icon: const Icon(
                          Icons.request_page,
                          color: Colors.white,
                        ),
                        child: TextFieldLabel(
                            alignment: Alignment.center,
                            text: "Request",
                            colorr: Colors.white,
                            padding: const EdgeInsets.all(0))),
                    Tab(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        child: TextFieldLabel(
                            alignment: Alignment.center,
                            text: "Completed",
                            colorr: Colors.white,
                            padding: const EdgeInsets.all(0))),
                  ]),
            ),
          ),
        ));
  }
}

// ignore: must_be_immutable
class BookingView extends StatelessWidget {
  List<BookModel> model;
  List<String> btn;
  BookingView({super.key, required this.model, required this.btn});

  @override
  Widget build(BuildContext context) {
    if (model.isEmpty) {
      return const Center(
        child: Text("No Data"),
      );
    }
    //print("Model");
    return Scaffold(
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<FetchNotificationBloc>().add(
                FetchNotificationDetailsClickedEvent(
                    token: getAccessToken(context)));
          },
          child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) {
                return BookingDetailsWidget(model, index, btn, context);
              }),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container BookingDetailsWidget(List<BookModel> model, int index,
      List<String> btn, BuildContext context) {
    FetchProfileState state = context.read<FetchProfileBloc>().state;

    String user_type = "";
    if (state is FetchProfileLoadedState) {
      user_type = state.userModel.user_type!;
    }

    // ignore: prefer_is_empty
    if (model.length == 0) {
      // ignore: avoid_unnecessary_containers
      return Container(
          child: const Center(
        child: Text("No Data"),
      ));
    }
    DateTime dateTime = StringToDate(model[index].booking_start_date_time!);
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user_type == 'customer'
                      ? requestViewTextLabel(
                          'To:', model[index].to!.user!.full_name)
                      : requestViewTextLabel(
                          'By:', model[index].by!.user!.full_name),
                  requestViewTextLabel(
                      'Phone:', model[index].by!.user!.phonenumber),
                  InkWell(
                    child: Row(
                      children: [
                        requestViewTextLabel('View ', null)
                        // Text(""),

                        ,
                        InkWell(
                          onTap: () {
                            try {
                              context.read<ChoosePlaceCubit>().change(
                                  LatLng(model[index].latitude!.toDouble(),
                                      model[index].longitude!.toDouble()),
                                  15);
                              context.read<LocationCubit>().showAddressByPoint(
                                  model[index].longitude!.toDouble(),
                                  model[index].latitude!.toDouble());
                            } catch (e) {
                              context
                                  .read<ChoosePlaceCubit>()
                                  .change(const LatLng(0, 0), 15);
                              context
                                  .read<LocationCubit>()
                                  .showAddressByPoint(0, 0);
                            }
                            showMapViewDialog(context);
                          },
                          child: const Icon(
                            Icons.location_on,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  requestViewTextLabel('${model[index].address}', null)
                  // Text(""),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  requestViewTextLabel("Date: ",
                      "${dateTime.year}-${dateTime.month}-${dateTime.day}"),
                  requestViewTextLabel(
                      "Time: ", "${dateTime.hour}:${dateTime.minute}"),
                  requestViewTextLabel(
                      "Expected Hours:", model[index].expected_hour),
                  requestViewTextLabel("Status: ${model[index].status}", null),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomElevatedButton(
                text: btn[0],
                width: 170,
                height: 40,
                onPressed: () {
                  if (btn[0] == 'Chat') {
                    print("chat");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return ChatPage(
                        id: model[index].to!.user!.id!,
                        model: model[index].by!.user!,
                        myId: model[index].by!.user!.id!,
                      );
                    }));
                  }

                  if (btn[0] == 'Reschedule') {
                    print("Reschedule");

                    showPopup(context,
                        model: model[index].to!, bookModel: model[index]);
                  }
                  if (btn[0] == "Accept") {
                    //print("AcceptClickedevent");
                    context.read<AcceptBookingBloc>().add(
                        AcceptBookingDetailsClickedEvent(
                            token: getAccessToken(context),
                            bookId: "${model[index].id!}"));
                  }

                  // if(btn[1)
                  if (btn[0] == 'Complete') {
                    //print("make complete");
                  }
                  if (btn[0] == 'Payment') {
                    print("payment ");

                    KhaltiPaymentGateway().paymentGateway(
                        context, model[index].id!, 1000, "booking");

                    //print('Cancel');
                  }

                  if (btn[0] == 'Chat') {}
                  context.read<FetchBookingBloc>().add(
                      FetchBookingDetailsClickedEvent(
                          token: getAccessToken(context)));
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                text: btn[1],
                width: 150,
                height: 40,
                onPressed: () {
                  if (btn[1] == 'Cancel') {
                    context.read<CancelBookingBloc>().add(
                        CancelBookingDetailsClickedEvent(
                            token: getAccessToken(context),
                            bookId: model[index].id.toString()));
                  }

                  if (btn[1] == 'Complete') {
                    context.read<MakeCompleteBloc>().add(
                        MakeCompleteClickedEvent(
                            token: getAccessToken(context),
                            bookId: model[index].id.toString()));
                  }
                  if (btn[1] == 'View Details') {
                    print("Chat");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return BookingDetails(
                        model: model[index],
                        key: key,
                      );
                    }));

                    return;
                  }
                  if (btn[1] == 'Chat') {}
                  context.read<FetchBookingBloc>().add(
                      FetchBookingDetailsClickedEvent(
                          token: getAccessToken(context)));
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          model[index].status == "completed"
              ? user_type != 'provider'
                  ? CustomElevatedButton(
                      text: "Give Review and Rate",
                      onPressed: () {
                        showReviewForm(context, bookId: model[index].id!);
                        // print("Give rate this rate");
                      },
                    )
                  : Container()
              : Container(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  static Row requestViewTextLabel(String textt, String? value) {
    final text = Text(
      textt,
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    );
    return Row(children: [
      text,
      TextFieldLabel(
          text: value ?? "",
          padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5, right: 5))
    ]);
  }
}
