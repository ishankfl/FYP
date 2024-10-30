import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/screen/loginsignup/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:bookme/data/model/loginsignupmodel/login_model.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';

// ignore: must_be_immutable
class CommonDetailsLogin extends StatelessWidget {
  CommonDetailsLogin({super.key});

  TextEditingController emailorphoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // context.read<FetchBookingBloc>().add(ClearBookingDetailsClickedEvent());
    context.read<LoginBloc>().add(ClearLoginDetail());

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          snacbar(context, "Error!", state.message!, false);
        } else if (state is LoginLoading) {
          snacbar(context, "Processing!", "Please wait for a second", false);
        } else if (state is LoginLoaded) {
          handleLoginSuccess(context, state.loginModel);
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Form(
          key: loginFormKey,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 34),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 60),
                  AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    child: Image.asset('assets/loginsignup/loginscreen.png'),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: LoginSignUpTitle(
                      context: context,
                      text: "Login with your account",
                      fontsize: 19,
                    ),
                  ),
                  const SizedBox(height: 39),
                  TextFieldLabel(text: "Email"),
                  CustomTextFormField(
                    fillColor: Colors.red,
                    filled: true,
                    validator: (value) {
                      if (value == "" || value == null) {
                        return "Email is required";
                      }
                      return null;
                    },
                    controller: emailorphoneController,
                  ),
                  const SizedBox(height: 22),
                  TextFieldLabel(text: "Password"),
                  CustomTextFormField(
                    controller: passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ForgotPasswordScreen();
                        }));
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text("Forgot password?"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomElevatedButton(
                        loading: state is LoginLoading,
                        text: "Login",
                        height: 57,
                        // width: 157,
                        onPressed: () {
                          if (loginFormKey.currentState!.validate()) {
                            
                            context.read<LoginBloc>().add(
                                  LoginClickedEvent(
                                    email: emailorphoneController.text,
                                    password: passwordController.text,
                                    rememberMe: true,
                                  ),
                                );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        GeneratedRoute().onGeneratedRoute(
                          const RouteSettings(
                              arguments: '', name: '/user_signup'),
                        ),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                          text: "Don’t have an account? Sign up",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleLoginSuccess(BuildContext context, LoginModel model) {
    snacbar(context, "Success!", "Successfully Login", true);

    if (model.user_type == "customer") {
      Navigator.push(
        context,
        GeneratedRoute().onGeneratedRoute(
          const RouteSettings(arguments: '', name: '/user_homepage'),
        ),
      );
    } else {
      Navigator.push(
        context,
        GeneratedRoute().onGeneratedRoute(
          const RouteSettings(arguments: '', name: '/provider_homepage'),
        ),
      );
    }
  }
}
