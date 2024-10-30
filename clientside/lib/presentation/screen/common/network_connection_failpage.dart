import 'package:flutter/material.dart';

class NetworkFailPage extends StatelessWidget {
  const NetworkFailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
              'assets/no_connection/no_animation.png'), // Replace 'assets/no_internet_image.png' with your actual image asset path

          Text("No internet access!"),
          Text("Please Connect to the internet"),
        ],
      )),
    );
  }
}
