import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:flutter/material.dart';

class PhotoViewPage extends StatelessWidget {
  String url;
  PhotoViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backBtnAppbar("Image"),
      body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Center(
            child: Image(
              image: NetworkImage(url),
            ),
          )),
    );
  }
}
