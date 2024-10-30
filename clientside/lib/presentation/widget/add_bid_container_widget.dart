import 'package:bookme/constant/colors.dart';
import 'package:flutter/material.dart';

class CustomeContainerBid {
  // ignore: non_constant_identifier_names
  static Widget CustomContainer(Widget widget) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstant.secondary_color_blue(),
        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      child: widget,
    );
  }
}
