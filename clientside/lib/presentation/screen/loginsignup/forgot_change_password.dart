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
class ChangePasswordScreen extends StatelessWidget {
  Map args;
  ChangePasswordScreen({super.key, required this.args});

  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordError) {
          snacbar(context, "Error!", state.message!, false);
        } else if (state is ChangePasswordLoading) {
          snacbar(context, "Processing!", "Please wait for a second", false);
        } else if (state is ChangePasswordLoaded) {
          handleForgotPwEmailSuccess(context, state.ChangePasswordModel);
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
                      text: "Enter Your New Password ",
                      fontsize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: LoginSignUpTitle(
                      context: context,
                      text:
                          "Your New Password Must Be Different From Previous Used Password.",
                      fontsize: 12,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFieldLabel(text: "New Password"),
                  CustomTextFormField(
                    fillColor: Colors.red,
                    filled: true,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Password");
                    },
                    controller: confirmpasswordController,
                  ),
                  const SizedBox(height: 20),
                  TextFieldLabel(text: "Confirm Password"),
                  CustomTextFormField(
                    fillColor: Colors.red,
                    filled: true,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Password");
                    },
                    controller: newpasswordController,
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        loading: state is LoginLoading,
                        text: "Change",
                        height: 57,
                        // width: 157,
                        onPressed: () {
                          print(args['email']);
                          if (loginFormKey.currentState!.validate()) {
                            String newPassword =
                                newpasswordController.text.trim();
                            String confirmPassword =
                                confirmpasswordController.text.trim();
                            if (newPassword == confirmPassword) {
                              context.read<ChangePasswordBloc>().add(
                                  ChangePasswordClickedEvent(
                                      password: newPassword,
                                      email: args['email']));
                            } else {
                              snacbar(context, "Error!",
                                  "Password must be the same", false);

                              // SnackBar(
                              //     content: CustomSnackbar.snacbar("Error",
                              //         ""));
                            }
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
    snacbar(context, "Success!", "Successfully Password Changed", true);

    Navigator.push(
      context,
      GeneratedRoute().onGeneratedRoute(
        RouteSettings(arguments: {
          'email': model.email,
          'secret_code': model.secret_code,
          'is_forgot_password': "is_forgot_password",
        }, name: '/login'),
      ),
    );
  }
}
