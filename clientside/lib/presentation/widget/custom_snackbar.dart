import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

// void showSnackbar(BuildContext context, String title, String message,
//     {bool contentType = true}) {
//   if (contentType == true) {
//     final snackBar =
//         CustomSnackbar.snacbar(title, message, ContentType.success);
//
//   }

//   if (contentType == false) {
//     final snackBar =
//         CustomSnackbar.snacbar(title, message, ContentType.failure);
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(snackBar);
//   }
// }

void snacbar(
    BuildContext context, String title, String message, bool contentType) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,

      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      showCloseIcon: false,
      closeIconColor: Colors.black,
      content: AwesomeSnackbarContent(
         
        color: Colors.blue,
        title: title,
        message: message,
        messageFontSize: 15,
        titleFontSize: 20,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType:
            contentType == true ? ContentType.success : ContentType.failure,
      ),
    ));
}
