import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widget/custom_elevated_button.dart';

void showReviewForm(BuildContext context, {required int bookId}) {
  TextEditingController reviewController = TextEditingController();
  double mainRating = 0;
  showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
            insetPadding: const EdgeInsets.all(15),
            title: const Column(children: [
              Text("Review the provider"),
              Text(
                "for this booking",
                style: TextStyle(fontSize: 15),
              )
            ]),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                // Form and other content
                Form(
                  // key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Rating bar, text field, submit button, etc.
                        RatingBar.builder(
                          allowHalfRating: true,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 40,
                          onRatingUpdate: (rating) {
                            print(rating);
                            mainRating = rating;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomTextFormField(
                              controller: reviewController,
                              hintText: "Write a review",
                              borderDecoration: InputBorder.none),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomElevatedButton(
                            backgroundColorBtn: Colors.amber,
                            text: 'Submit',
                            onPressed: () {
                              print(mainRating);
                              print(reviewController.text);
                              context.read<AddReviewBloc>().add(
                                  AddReviewClickedEvent(
                                      token: getAccessToken(context),
                                      bookId: "$bookId",
                                      description: reviewController.text.trim(),
                                      rate: "$mainRating"));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Close button
                Positioned(
                  right: 10,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      print("Close the window please wait...");
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ));
}
