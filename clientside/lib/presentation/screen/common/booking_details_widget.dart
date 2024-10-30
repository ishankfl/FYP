import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:bookme/logic/bloc/fetch_booking_request/fetch_request_state.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

class BookingDetailWidget {
  static Container BookingDetailsWidget(
      FetchBookingLoaded? state, int index, List<BookModel> content) {
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
                  requestViewTextLabel(
                      'By:', state!.bookModel![index].by!.user!.full_name),
                  requestViewTextLabel(
                      'Phone:', state.bookModel![index].by!.user!.phonenumber),
                  Row(
                    children: [
                      requestViewTextLabel('View ', null)
                      // Text(""),

                      ,
                      const Icon(Icons.location_on),
                    ],
                  ),
                  requestViewTextLabel(
                      '${state.bookModel![index].address}', null)
                  // Text(""),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  requestViewTextLabel("Date: 2023-12-12", null),
                  requestViewTextLabel("Time: 9:00 pm", null),
                  requestViewTextLabel("Expected Hours: 2", null),
                  requestViewTextLabel(
                      "Status: ${content[index].status}", null),
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
                text: content[index].status == 'pending'
                    ? "Accept"
                    : content[index].status == 'confirmed'
                        ? "Cancel"
                        : "View History",
                width: 150,
                height: 40,
                onPressed: () {
                  // if()
                },
              ),
              const Spacer(),
              CustomElevatedButton(
                text: "Reject",
                width: 150,
                height: 40,
              ),
            ],
          ),
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
          fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
    );
    return Row(children: [
      TextFieldLabel(text: textt),
      TextFieldLabel(text: value != null ? value : "")
    ]);

    // return text;
  }

  static Column BookingUserWidget(
      FetchBookingLoaded? state, int index, List<BookModel> content) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                requestViewTextLabel(
                    'By:', state!.bookModel![index].by!.user!.full_name),
                requestViewTextLabel(
                    'Phone:', state.bookModel![index].by!.user!.phonenumber),
                Row(
                  children: [
                    requestViewTextLabel('View ', null)
                    // Text(""),

                    ,
                    const Icon(Icons.location_on),
                  ],
                ),
                requestViewTextLabel('Ithari Nepal', null)
                // Text(""),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                requestViewTextLabel("Date: 2023-12-12", null),
                requestViewTextLabel("Time: 9:00 pm", null),
                requestViewTextLabel("Expected Hours: 2", null),
                requestViewTextLabel("Status: ${content[index].status}", null),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  // static Row requestViewTextLabel(String textt, String? value) {
  //   final text = Text(
  //     textt,
  //     style: const TextStyle(
  //         fontSize: 12, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
  //   );
  //   return Row(children: [
  //     TextFieldLabel(text: textt),
  //     TextFieldLabel(text: value != null ? value : "")
  //   ]);

  //   // return text;
  // }
}
