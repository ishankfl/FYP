import 'package:bookme/constant/colors.dart';
import 'package:bookme/data/model/notification_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jiffy/jiffy.dart';

class NotificationTap extends StatelessWidget {
  const NotificationTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.prmary_color_notdart(),
      appBar: backBtnAppbar("Notification"),
      body: SafeArea(
          child: BlocBuilder<FetchNotificationBloc, FetchNotificationState>(
        builder: (context, state) {
          if (state is FetchNotificationLoaded) {
            List<NotificationModel> model = state.model;

            return SingleChildScrollView(
                child: RefreshIndicator(
              onRefresh: () async {
                context.read<FetchNotificationBloc>().add(
                    FetchNotificationDetailsClickedEvent(
                        token: getAccessToken(context)));
              },
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: model.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        NotificationModel newModel = model[index];
                        String timeAgo = Jiffy.parseFromDateTime(
                                DateTime.parse(newModel.time!))
                            .fromNow();

                        return Container(
                          color: ColorConstant.prmary_color_notdart(),
                          child: ListTile(
                            onFocusChange: (value) {
                              print(value);
                            },
                            focusColor: ColorConstant.prmary_color_notdart(),
                            selectedTileColor:
                                ColorConstant.prmary_color_notdart(),
                            selectedColor: ColorConstant.prmary_color_notdart(),
                            trailing: Icon(Icons.more_horiz),
                            horizontalTitleGap: 20,
                            contentPadding: EdgeInsets.all(10),
                            leading: ClipOval(
                              child: Container(
                                height: 100,
                                width: 60,
                                color: Colors.red,
                                child: CustomImage(
                                  imagepath:
                                      newModel.sender!.profile.toString(),
                                ),
                              ),
                            ),
                            subtitle: Text(timeAgo),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${newModel.id} ${newModel.sender!.full_name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                // Spacer(),
                                Text(newModel.body!)
                              ],
                            ),
                            onTap: () {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //   content: Text("Notification $index"),
                              // ));
                            },
                          ),
                        );
                      })
                ],
              ),
            ));
          }
          if (state is FetchNotificationEmpty) {
            return Center(
              child: Text("No things to view"),
            );
          }
          if (state is FetchNotificationError) {
            return ErrorFetchingData(
              message: state.message!,
              btnName: "Retry",
              onPressed: () {
                print("pressed");
                context.read<FetchNotificationBloc>().add(
                    FetchNotificationDetailsClickedEvent(
                        token: getAccessToken(context)));
              },
            );
          }
          if (state is FetchNotificationLoading) {
            return Center(child: CircularProgressIndicator());
          }
          context.read<FetchNotificationBloc>().add(
              FetchNotificationDetailsClickedEvent(
                  token: getAccessToken(context)));
          return ErrorFetchingData(
            message: "Please try again",
            btnName: "Try again",
            onPressed: () {
              context.read<FetchNotificationBloc>().add(
                  FetchNotificationDetailsClickedEvent(
                      token: getAccessToken(context)));
            },
          );
        },
      )),
    );
  }
}
