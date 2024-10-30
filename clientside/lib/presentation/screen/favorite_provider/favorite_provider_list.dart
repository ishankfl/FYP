import 'package:bookme/logic/bloc/favorite_provider/fetch_fav_provider_bloc.dart';
import 'package:bookme/logic/bloc/favorite_provider/fetch_fav_provider_event.dart';
import 'package:bookme/logic/bloc/favorite_provider/fetch_fav_provider_state.dart';
import 'package:bookme/logic/bloc/favorite_provider/make_favorite_bloc.dart';
import 'package:bookme/logic/bloc/favorite_provider/make_favorite_event.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/booking/booked_provider.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:flutter/material.dart';

class FavProviderList extends StatelessWidget {
  const FavProviderList({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<FetchFavProviderBloc>().add(
    //     FetchFavProviderDetailsClickedEvent(token: getAccessToken(context)));

    return Scaffold(
      appBar: backBtnAppbar("My Provider"),
      body: SafeArea(
          child: Center(
              child: FavoriteProviderCard(
        favOnly: true,
      ))),
    );
  }
}
