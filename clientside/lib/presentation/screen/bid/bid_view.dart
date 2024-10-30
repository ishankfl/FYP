import 'dart:math';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/logic/services/stringtodate.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/presentation/widget/photo_view_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class BidView extends StatelessWidget {
  final BidModel model;

  BidView({required this.model, super.key});
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: backBtnAppbar("Bid"),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClippingApp(
              model: model,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldLabel(
                    fontsize: 26,
                    text: model.service!.service_name.toString(),
                    padding: const EdgeInsets.all(0),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'User: ${model.user?.full_name ?? "Unknown User"}',
                    // style: CustomTextStyle.regularTextStyle,
                  ),
                  Text(
                      'Date: ${StringToDate(model.timestamp.toString()).year}-${StringToDate(model.timestamp.toString()).month}-${StringToDate(model.timestamp.toString()).day} ${StringToDate(model.timestamp.toString()).hour}:${StringToDate(model.timestamp.toString()).minute}'
                      // style: CustomTextStyle.regularTextStyle,
                      ),
                  Text(
                    'Location: ${model.location}',
                    // style: CustomTextStyle.regularTextStyle,
                  ),
                  Text(model.textcontent != null
                      ? model.textcontent.toString()
                      : "")
                ],
              ),
            ),
            BidCommentView(model: model),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                controller: amountController,
                hintText: "Add bet ${model.id}",
                suffix: InkWell(
                  onTap: () {
                    amountController.clear();
                    context.read<AddBidCommentBloc>().add(
                        AddBidCommentBtnPressed(
                            bidId: model.id.toString(),
                            text: amountController.text.trim(),
                            token: getAccessToken(context)));
                    // BlocProvider.of<FetchBidListBloc>(context).add(
                    //     FetchBidListClickedEvent(token: getAccessToken(context)));
                    context.read<FetchCommentBloc>().add(
                        FetchCommentClickedEvent(
                            token: getAccessToken(context),
                            bidId: model.id.toString()));
                  },
                  child: const Icon(
                    IconlyBold.send,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ClippingApp extends StatelessWidget {
  BidModel model;
  ClippingApp({required this.model, super.key});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedBottomClipper(),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return PhotoViewPage(
                url: '${ServerUrl.ipaddress()}${model.image.toString()}');
          }));
        },
        child: Image(
          errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.red,
              alignment: Alignment.center,
              height: 230,
              child: Image.network(
                  cacheHeight: 200,
                  "${ServerUrl.ipaddress()}media/emptyimage/empyt_kI8bDG5.png")),
          fit: BoxFit.cover,
          height: 230,
          width: MediaQuery.of(context).size.width,
          image: NetworkImage(
            '${ServerUrl.ipaddress()}${model.image}',
          ),
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 3 / 9;

    // this is top part of path, rectangle without any rounding
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight - 15);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -5, size.height - roundingHeight * 2, size.width + 5, size.height - 30);

    final path = Path();
    path.addRect(filledRectangle);

    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BidCommentView extends StatelessWidget {
  BidModel? model;
  BidCommentView({this.model, super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FetchCommentBloc>().add(
        FetchCommentClickedEvent(token: getAccessToken(context), bidId: "32"));

    return BlocBuilder<FetchCommentBloc, FetchCommentState>(
      builder: (context, state) {
        if (state is FetchCommentLoaded) {
          return Column(children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 240,
                child: ListView.builder(
                  shrinkWrap: true,
                  // physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.model.length,
                  itemBuilder: (context, index) {
                    final comment = state.model[index];
                    return Container(
                      // margin: EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(255, 248, 245, 245)),
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorConstant.prmary_color_notdart()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                CustomImage(
                                    height: 50,
                                    imagepath:
                                        comment.user!.profile.toString()),
                                Text(comment.user!.full_name
                                    .toString()
                                    .split(" ")[0]),
                              ],
                            ),
                            const Spacer(),
                            Text(comment.text!)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ]);
        }
        if (state is FetchCommentEmpty) {
          return Container(
            child: Center(
              child: Text("Add your first bet"),
            ),
          );
        }
        if (state is FetchCommentError) {
          return ErrorFetchingData(
            btnName: "Retry",
            onPressed: () {
              context.read<FetchCommentBloc>().add(FetchCommentClickedEvent(
                  token: getAccessToken(context), bidId: "${model!.id}"));
            },
            message: "please click button and try again",
          );
        }
        context.read<FetchCommentBloc>().add(FetchCommentClickedEvent(
            token: getAccessToken(context), bidId: "${model!.id}"));
        return ErrorFetchingData(message: "Try again please", btnName: "Retry");
      },
    );
  }
}
