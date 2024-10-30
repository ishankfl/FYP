import 'package:flutter/material.dart';

LoginSignUpTitle({
  required double fontsize,
  required context,
  required String text,
}) {
  return Text(
    text,
    style: TextStyle(
        color: const Color.fromRGBO(9, 54, 96, 1),
        fontSize: fontsize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins'),
  );
}

// TextFieldLabel(
//     {required double fontsize, required context, required String text}) {
//   return Text(
//     text,
//     style: TextStyle(
//         color: Color.fromRGBO(0, 0, 0, 1),
//         fontSize: fontsize,
//         fontFamily: 'Poppins'),
//   );
// }

Container TextFieldLabel(
    {required String text,
    Color? colorr,
    double? fontsize,
    EdgeInsets? padding,
    TextAlign? text_align,
    Alignment? alignment}) {
  return Container(
    alignment: alignment ?? Alignment.centerLeft,
    child: Padding(
      padding: padding ?? EdgeInsets.only(left: 12.0, bottom: 10),
      child: Text(
        textAlign: text_align ?? TextAlign.center,
        text,
        style: TextStyle(
          color: colorr ?? Color.fromRGBO(0, 0, 0, 1),
          fontSize: fontsize ?? 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
