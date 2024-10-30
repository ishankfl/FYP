// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/presentation/widget/border_shadow.dart';
import 'package:flutter/material.dart';

import 'package:bookme/constant/server.dart';

class CustomImage extends StatelessWidget {
  String imagepath;
  int? height;
  int? width;

  CustomImage({Key? key, required this.imagepath, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          // BorderShadow.shadow(color: Color.fromARGB(105, 226, 210, 209))
        ],
        // color: Colors.red,
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      // width: 30,
      child: ClipOval(
        child: imagepath != ""
            ? Container(
                height: double.tryParse("$height") ?? 100,
                child: Image.network(
                  ServerUrl.ipaddress() + imagepath.substring(1),
                  fit: BoxFit.cover,
                  cacheHeight: height ?? 100,
                  cacheWidth: width ?? 40,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // You can return a placeholder image or an error widget here
                    return CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: double.tryParse("$height") ?? 100,
                      ),
                    );
                  },
                ),
              )
            : Icon(Icons.person, color: const Color.fromARGB(255, 36, 30, 30)),
      ),
    );
  }
}

customeImage(String image, BuildContext context) {
  return Container(
    height: 150,
    decoration: BoxDecoration(
        color: ColorConstant.secondary_color_blue(),
        borderRadius: BorderRadius.circular(10)),
    width: MediaQuery.of(context).size.width / 2,
    child: Image.network(
      "",
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text("Empty\nImage"));
      },
    ),
  );
}
