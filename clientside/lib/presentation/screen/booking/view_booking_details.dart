import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:flutter/material.dart';

class BookingDetails extends StatelessWidget {
  final BookModel model;
  const BookingDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBtnAppbar("Booking Details"),
      body: SafeArea(child: Container()),
    );
  }
}
