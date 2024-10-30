import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class ErrorFetchingData extends StatelessWidget {
  VoidCallback? onPressed;
  String message;
  String? btnName;
  ErrorFetchingData({
    super.key,
    this.onPressed,
    required this.message,
    required this.btnName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          SizedBox(
            height: 10,
          ),
          btnName != ""
              ? CustomElevatedButton(
                  text: btnName!,
                  onPressed: onPressed,
                  width: 120,
                  height: 45,
                )
              : Container()
        ],
      ),
    );
  }
}
