import 'dart:io';

import 'package:bookme/constant/verficationfields.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:flutter/material.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  TextEditingController emailorphoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordError) {
          snacbar(context, "Error!", state.message!, false);
        } else if (state is ForgotPasswordLoading) {
          snacbar(context, "Processing!", "Please wait for a second", false);
        } else if (state is ForgotPasswordLoaded) {
          handleForgotPwEmailSuccess(context, state.forgotPasswordModel);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        // resizeToAvoidBottomInset: false,
        body: Form(
          key: loginFormKey,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: LoginSignUpTitle(
                      context: context,
                      text: "Forgot Password? ",
                      fontsize: 24,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: LoginSignUpTitle(
                      context: context,
                      text:
                          "Don't worry! It occurs. Please enter the email address linked with your account.",
                      fontsize: 12,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFieldLabel(text: "Email"),
                  CustomTextFormField(
                    fillColor: Colors.red,
                    filled: true,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Email");
                    },
                    controller: emailorphoneController,
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        loading: state is ForgotPasswordLoading,
                        text: "Send Code",
                        height: 57,
                        // width: 157,
                        onPressed: () {
                          if (loginFormKey.currentState!.validate()) {
                            context.read<ForgotPasswordBloc>().add(
                                  ForgotPasswordClickedEvent(
                                    email: emailorphoneController.text,
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleForgotPwEmailSuccess(BuildContext context, UserModel model) {
    snacbar(context, "Success!", "Successfully Login", true);

    Navigator.push(
      context,
      GeneratedRoute().onGeneratedRoute(
        RouteSettings(arguments: {
          'email': model.email,
          'secret_code': model.secret_code,
          'is_forgot_password': "is_forgot_password",
        }, name: '/verify_account'),
      ),
    );
  }
}
