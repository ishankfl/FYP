import 'package:bookme/logic/bloc/verification/verification_bloc.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AccountVerification extends StatelessWidget {
  String? email;
  Map? args;
  AccountVerification({super.key, this.args});
  TextEditingController verificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var verificationFormKey = GlobalKey<FormState>();
    return BlocListener<VerificationBloc, VerificationState>(
      listener: (context, state) {
        if (state is VerificationLoaded) {
          if (state.verifyModel.is_forgot_password == "is_forgot_password") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfull'),
              duration: Duration(seconds: 1),
            ));
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(RouteSettings(arguments: {
                  'email': state.verifyModel.email,
                }, name: '/forgot_password_change')));
            return;
          }
          if (state.verifyModel.user_type == "customer") {
            snacbar(context, "Error", "Successfully verified", true);
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(
                    const RouteSettings(arguments: {}, name: '/login')));
            return;
          } else {            
            snacbar(context, "Error", "Successfully Verified", false);
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(RouteSettings(arguments: {
                  'email': state.verifyModel.email,
                  'services': state.verifyModel.services
                }, name: '/service_provider_signup')));
            return;
          }
        }

        if (state is VerificationLoading) {
          snacbar(context, "Error", "Loading..", false);
          return;
        }

        if (state is VerificationError) {
          snacbar(context, "Error", state.message!, false);
          return;
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: verificationFormKey,
            child: Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Image.asset('assets/loginsignup/verify.png')),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: LoginSignUpTitle(
                          context: context,
                          text: "Verify your account",
                          fontsize: 19,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          child:
                              Image.asset('assets/loginsignup/iconverify.png'))
                    ],
                  ),
                  const SizedBox(height: 25),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                          width: 320,
                          // margin: EdgeInsets.only(right: 40),
                          child: Text(
                            "Please enter the 6 digit code sent to your email. The code will expired after 5 minutes.${args!['secret_code']}",
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            // style: CustomTextStyles.bodySmallGray700
                            //     .copyWith(height: 1.50)
                          ))),
                  const SizedBox(height: 43),
                  PinCodeTextField(
                    controller: verificationController,
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: Color.fromRGBO(9, 54, 96, 1),
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      try {
                        int? num = int.parse(v.toString());
                        if (v!.length < 6) {
                          return "Required 6 digits";
                        } else {
                          return null;
                        }
                        return null;
                      } catch (e) {
                        return "Fields must be integer";
                      }
                    },
                    pinTheme: PinTheme(
                        disabledColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 38,
                        fieldWidth: 45,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                        inactiveFillColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        inactiveColor: const Color.fromRGBO(191, 176, 176, 1),
                        activeColor: const Color.fromRGBO(191, 176, 176, 1),
                        selectedColor: const Color.fromRGBO(191, 176, 176, 1)),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<VerificationBloc, VerificationState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                          height: 48,
                          width: 143,
                          text: "Verify",
                          loading: state is VerificationLoading,
                          // buttonTextStyle: CustomTextStyles.titleSmallArialWhiteA700,
                          onPressed: () {
                            if (verificationFormKey.currentState!.validate()) {
                              context.read<VerificationBloc>().add(
                                  VerificationClickEvent(
                                      secret_code:
                                          args!['secret_code'].toString(),
                                      email: args!['email'].toString(),
                                      otp: verificationController.text,
                                      is_forgot_password:
                                          args!['is_forgot_password'] ?? ""));
                            }
                          });
                    },
                  ),
                  const SizedBox(height: 50),
                  RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          text: "Didn’t receive the code? ",
                        ),
                        TextSpan(
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                          text: "Resend it ",
                          // style: theme.textTheme.bodyMedium!
                          //     .copyWith(decoration: TextDecoration.underline)
                        )
                      ]),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 5)
                ])),
          )),
    );
  }
}
