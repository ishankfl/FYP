import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';

AppBar backBtnAppbar(String title,
    {PreferredSizeWidget? bottonBar,
    BuildContext? context,
    bool? redirect_homepage}) {
  return AppBar(
    // leading: BackButton(),
    bottom: bottonBar,
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: ColorConstant.primary_color_dark(),
    title: TextFieldLabel(
        text: title,
        padding: const EdgeInsets.all(0),
        fontsize: 20,
        colorr: Colors.white),
  );
}
