import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class LoginSignUpChoosen extends StatelessWidget {
  const LoginSignUpChoosen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Image.asset('assets/loginsignup/choosenscreenimg.png'),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/splash/logo.png'),
                ),
                const SizedBox(
                  height: 122,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomElevatedButton(
                          backgroundColorBtn: Colors.white,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                              border: Border.all(
                                width: 2.5,
                                color: const Color.fromRGBO(9, 54, 96, 1),
                              )),
                          height: 57,
                          width: 167,
                          text: "LOG IN",
                          buttonTextStyle: const TextStyle(
                              color: Color.fromRGBO(9, 54, 96, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'),
                          onPressed: () {
                            // context.read<IndexCubit>()..increment(context);
                            // onTapNext(context);

                            Navigator.push(
                                context,
                                GeneratedRoute().onGeneratedRoute(
                                  const RouteSettings(
                                      arguments: '', name: '/login'),
                                ));
                          },
                          alignment: Alignment.center),
                      CustomElevatedButton(
                          height: 57,
                          width: 167,
                          text: "REGISTER",
                          onPressed: () {
                            Navigator.push(
                                context,
                                GeneratedRoute().onGeneratedRoute(
                                  const RouteSettings(
                                      arguments: '', name: '/user_signup'),
                                ));
                            // context.read<IndexCubit>()..increment(context);
                            // onTapNext(context);
                          },
                          alignment: Alignment.center),
                    ],
                  ),
                )
              ],
            )));
  }
}
