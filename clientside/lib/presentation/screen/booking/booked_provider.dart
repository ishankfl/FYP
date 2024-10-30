// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import 'package:bookme/logic/bloc/favorite_provider/make_favorite_bloc.dart';
import 'package:bookme/logic/bloc/favorite_provider/make_favorite_event.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';

class BookedProvider extends StatelessWidget {
  const BookedProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBtnAppbar("Booked Provider"),
      body: SafeArea(
          child: Center(
        child: FavoriteProviderCard(
          favOnly: false,
        ),
      )),
    );
  }
}

class FavoriteProviderCard extends StatelessWidget {
  bool favOnly;
  FavoriteProviderCard({
    Key? key,
    required this.favOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBookingBloc, FetchBookingState>(
      builder: (context, state) {
        if (state is FetchBookingLoaded) {
          print("on booked provider page");
          print(state.bookModel);
          Set<int> uniqueUserIds = {};

          print(state.bookModel);
          return ListView.builder(
            itemCount: state.bookModel!.length,
            itemBuilder: (context, index) {
              int userId = state.bookModel![index].to!.user!.id!;

              // Check if user ID is already in the set
              if (!uniqueUserIds.contains(userId)) {
                // state.bookModel![index].favorite_provider?.is_favorit=false;
                if (state.bookModel![index].favorite_provider?.is_favorit ==
                    true) {
                  uniqueUserIds.add(userId);
                } else {
                  uniqueUserIds.add(userId);
                }
                // if(favOnly==true){
                if (state.bookModel![index].favorite_provider!.is_favorit ==
                        false &&
                    favOnly == true) {
                  return Container();
                }


                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(state.bookModel![index].to!.user!.full_name!),
                    subtitle:
                        Text(state.bookModel![index].service!.service_name!),
                    leading: CustomImage(
                      width: 100,
                      imagepath:
                          state.bookModel![index].to!.user!.profile.toString(),
                    ),
                    trailing: IgnorePointer(
                      ignoring: favOnly,
                      child: FavoriteButton(
                        iconSize: 50,
                        iconColor: Colors.red,
                        // isFavorite: true,
                        isFavorite:
                            state.bookModel![index].favorite_provider != null
                                ? state.bookModel![index].favorite_provider!
                                    .is_favorit!
                                : false,
                        iconDisabledColor:
                            const Color.fromARGB(179, 52, 49, 49),
                        valueChanged: (_isFavorite) {
                          context.read<FavoriteProviderBloc>().add(
                              FavoriteProviderClickedEvent(
                                  isFavorite: _isFavorite,
                                  serviceProvider:
                                      "${state.bookModel![index].to!.user!.id}",
                                  token: getAccessToken(context)));
                          context.read<FetchBookingBloc>().add(
                              FetchBookingDetailsClickedEvent(
                                  token: getAccessToken(context)));
                          // print(
                          //     'Is Favorite ${state.bookModel![index].favorite_provider!.is_favorit!}');
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Container(); // Return an empty container for duplicates
              }
            },
          );
        }
        if (state is FetchBookingError) {
          ErrorFetchingData(
            message: "Error to getting data",
            btnName: "Try again",
            onPressed: () {
              context.read<FetchBookingBloc>().add(
                  FetchBookingDetailsClickedEvent(
                      token: getAccessToken(context)));
            },
          );
        }
        if (state is FetchBookingLoading) {
          return CircularProgressIndicator();
        }
        // context.read<FetchBookingBloc>().add(
        //     FetchBookingDetailsClickedEvent(
        //         token: getAccessToken(context)));
        return ErrorFetchingData(
          message: "Error to getting data",
          btnName: "Retry",
          onPressed: () {
            context.read<FetchBookingBloc>().add(
                FetchBookingDetailsClickedEvent(
                    token: getAccessToken(context)));
          },
        );
      },
    );
  }
}
