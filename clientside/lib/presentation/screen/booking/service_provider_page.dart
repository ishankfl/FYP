// ignore_for_file: must_be_immutable

import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/data/model/service_provider_model.dart';
import 'package:bookme/data/model/services_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/booking/booking_page.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/presentation/widget/user_profile_image_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServiceProviderDetailView extends StatelessWidget {
  List? args;
  ServiceProviderDetailView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    LoginState state = context.watch<LoginBloc>().state;
    String accesstoken = '';
    if (state is LoginLoaded) {
      accesstoken = state.loginModel.access.toString();
      // print(accesstoken);
    }
    ServicesModel newModel = ServicesModel();
    newModel.id = int.parse(args![0]);
    newModel.service_name = args![1];

    context
        .read<FetchProviderBloc>()
        .add(FetchProviderHit(id: int.parse(args![0]), newToken: accesstoken));

    return Scaffold(
        appBar: backBtnAppbar(
          args![1],
        ),
        body: BlocBuilder<FetchProviderBloc, FetchProviderState>(
          builder: (context, state) {
            if (state is FetchProviderLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FetchProviderErrorState) {
              return ErrorFetchingData(
                onPressed: () {
                  // print("Recall");
                  context.read<FetchProviderBloc>().add(FetchProviderHit(
                      id: int.parse(args![0]), newToken: accesstoken));
                },
                btnName: "Retry",
                message: "Error to fetching data",
              );
            }
            if (state is FetchProviderEmptyState) {
              return Center(
                child: ErrorFetchingData(
                  onPressed: () {
                    print("Recall");
                    context.read<FetchProviderBloc>().add(FetchProviderHit(
                        id: int.parse(args![0]), newToken: accesstoken));
                  },
                  btnName: "Refresh",
                  message: "No service provider is available for this project",
                ),
              );
            }

            if (state is FetchProviderLoadedState) {
              if (state.providerModel.isEmpty) {
                return const Center(
                  heightFactor: double.infinity,
                  child: Text("No service provider is available"),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ServiceProviderListView(
                        isEmergency: false,
                        serviceType: newModel,
                        providerModel: state.providerModel,
                        key: key,
                        // args,
                      )
                    ],
                  ),
                );
              }
            }
            context.read<FetchProviderBloc>().add(FetchProviderHit(
                id: int.parse(args![0]), newToken: accesstoken));
            return MaterialButton(
              onPressed: () {
                context.read<FetchProviderBloc>().add(FetchProviderHit(
                    id: int.parse(args![0]), newToken: accesstoken));
              },
              child: const Text("call api"),
            );
          },
        ));
  }

//   Padding ServiceProviderListView(String? type, String accesstoken,
//       List<ServiceProviderModel> providerModel) {

//   }
}

class ProviderDetailText extends StatelessWidget {
  const ProviderDetailText({
    super.key,
    required this.text,
    required this.weight,
    required this.size,
  });

  final String text;
  final FontWeight weight;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(
        text,
        style: TextStyle(
            fontSize: size.toDouble(),
            fontFamily: 'Poppins',
            fontWeight: weight,
            color: const Color.fromARGB(
              255,
              9,
              54,
              96,
            )),
      ),
    );
  }
}

class ServiceProviderListView extends StatelessWidget {
  final List<ServiceProviderModel> providerModel;
  final ServicesModel serviceType;
  final bool? isEmergency;
  ServiceProviderListView(
      {super.key,
      this.isEmergency = false,
      required this.providerModel,
      required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          dragStartBehavior: DragStartBehavior.down,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 22.0,
              mainAxisSpacing: 22.0,
              childAspectRatio: 1.6),
          itemCount: providerModel.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
                // alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.5), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 6, // blur radius
                        offset:
                            const Offset(0, 2), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.blue,
                            )
                          ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 65.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceBetween, // or MainAxisAlignment.spaceAround

                          children: [
                            Column(
                              children: [
                                UserProfileImageCircleAvatar(
                                  profileUrl:
                                      providerModel[index].user?.profile,
                                  key: key,
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProviderDetailText(
                                    text: "Type: ${serviceType.service_name!}",
                                    weight: FontWeight.w600,
                                    size: 15),
                                ProviderDetailText(
                                    text:
                                        "Location: ${providerModel[index].user!.city.toString()}",
                                    weight: FontWeight.w600,
                                    size: 15),
                                Container(
                                  // width: 30,
                                  child: ProviderDetailText(
                                      text:
                                          "Experience: ${providerModel[index].experience.toString()}",
                                      weight: FontWeight.w600,
                                      size: 15),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            // mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            children: [
                              ProviderDetailText(
                                  text:
                                      "${providerModel[index].user!.full_name}",
                                  weight: FontWeight.w700,
                                  size: 18),
                              const SizedBox(
                                height: 20,
                              ),
                              IgnorePointer(
                                ignoring: true,
                                child: RatingBar.builder(
                                  initialRating:
                                      providerModel[index].averagerating ?? 1,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemSize: 20,
                                  // allowHalfRating: true,
                                  onRatingUpdate: (rating) {},
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {},
                                  child: CustomElevatedButton(
                                    text: "Book",
                                    width: 100,
                                    height: 40,
                                    onPressed: () {
                                      if (isEmergency == true) {
                                        String address = '';
                                        double long = 0;
                                        double lat = 0;
                                        LocationState locationState =
                                            context.read<LocationCubit>().state;
                                        if (locationState is LocationLoaded) {
                                          address = locationState.location;
                                          long = locationState.lonlag[0];
                                          lat = locationState.lonlag[1];
                                        }
                                        DateTime dateTime = DateTime.now();
                                        String date =
                                            "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
                                        print(dateTime);
                                        context.read<BookingBloc>().add(
                                            BookingClickedEvent(
                                                address: address,
                                                service: "${serviceType.id}",
                                                provider:
                                                    "${providerModel[index].id}",
                                                start_date_time: date,
                                                expectedHours: "2",
                                                longitude: "$long",
                                                latitude: "$lat",
                                                token: getAccessToken(context),
                                                location: address));
                                        return;
                                      }
                                      providerModel[index].user!.access =
                                          getAccessToken(context);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (builder) {
                                        return BookingTimeDetails(
                                            model: providerModel[index]);
                                      }));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
