import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/presentation/screen/notification/notification_view_page.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';

class CustomAppBarTop {
  static AppBar customAppBar(BuildContext context) {
    final String accessToken = getAccessToken(context);

    return AppBar(
      backgroundColor: ColorConstant.primary_color_dark(),
      automaticallyImplyLeading: false,
      actions: [
        MultiBlocListener(
          listeners: [
            BlocListener<FetchProfileBloc, FetchProfileState>(
              listener: (context, state) {
                if (state is FetchProfileErrorState) {
                  snacbar(context, "Token is expired!", "Please login again",
                      false);
                }
              },
            ),
          ],
          child: Container(),
        ),
        BlocBuilder<FetchProfileBloc, FetchProfileState>(
          builder: (context, state) {
            if (state is FetchProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FetchProfileErrorState) {
              return MaterialButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   GeneratedRoute().onGeneratedRoute(
                    //     const RouteSettings(
                    //         arguments: '', name: '/user_homepage'),
                    //   ),
                    // );
                  },
                  child: const Icon(Icons.error));
            }

            if (state is FetchProfileLoadedState) {
              return buildProfileRow(context, state.userModel);
            }

            context.read<FetchProfileBloc>().add(
                  FetchProfileHit(newToken: accessToken),
                );

            return MaterialButton(onPressed: () {});
          },
        ),
        const Spacer(),
        const Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return const NotificationTap();
            }));
          },
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static Widget buildProfileRow(BuildContext context, UserModel userModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              GeneratedRoute().onGeneratedRoute(
                const RouteSettings(arguments: '', name: '/viewprofile'),
              ),
            );
          },
          child: Row(
            children: [
              Container(
                height: 35,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: CustomImage(
                  height: 50,
                  width: 50,
                  imagepath: userModel.profile!,
                ),
              ),
              Text(
                userModel.full_name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 35),
        Row(
          children: [
            userModel.city != null
                ? Text(
                    userModel.city.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  )
                : const Text("No"),
          ],
        ),
      ],
    );
  }
}
