import 'package:bookme/constant/verficationfields.dart';
import 'package:bookme/logic/bloc/signup/user_signup_bloc.dart';
import 'package:bookme/logic/cubit/dropdown_change.dart/dropdown_cubit.dart';
import 'package:bookme/logic/cubit/dropdown_change.dart/dropdown_state.dart';
import 'package:bookme/logic/cubit/location/location_cubit.dart';
import 'package:bookme/logic/cubit/location/location_state.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UserSignUp extends StatelessWidget {
  UserSignUp({super.key});
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final signUpFormKey = GlobalKey<FormState>();
  // String selectedValue = 'Option 1'; // Initial selected value
  List<String> userTypeChoose = ['provider', 'customer'];
  String? userChoosed = "customer";
  String? userChoosedDisplay = "Customer";
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpUserBloc, SignUpUserState>(
      listener: (context, state) {
        if (state is SignUpUserLoading) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please Wait'),
            duration: Duration(seconds: 1),
          ));
        }

        // if (state is SignUpUserLoading) {}
        if (state is SignUpUserLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Success'),
              duration: Duration(seconds: 1),
            ),
          );

          Navigator.push(
              context,
              GeneratedRoute().onGeneratedRoute(RouteSettings(arguments: {
                'email': state.userModel.email,
                'secret_code': state.userModel.secret_code
              }, name: '/verify_account')));
        }
        if (state is SignUpUserError) {
          // ScaffoldMessenger.of(kafle
        }
      },
      child: BlocBuilder<SignUpUserBloc, SignUpUserState>(
        builder: (context, state) {
          return Scaffold(
            // resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: UserDetailsForm(context),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView UserDetailsForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: signUpFormKey,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 34),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(
                  //   height: 60,
                  // ),
                  Image.asset(
                    'assets/loginsignup/signupscreen.png',
                    height: 150,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: LoginSignUpTitle(
                      context: context,
                      text: "Create and account",
                      fontsize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldLabel(text: "Full Name"),
                  CustomTextFormField(
                    focusNode: null,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Fullname");
                    },
                    controller: fullNameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldLabel(text: "Email"),
                  CustomTextFormField(
                    focusNode: null,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Email");
                    },
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldLabel(text: "City"),
                  CustomTextFormField(
                    focusNode: null,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "City");
                    },
                    controller: cityController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldLabel(text: "Phonenumber"),
                  CustomTextFormField(
                    focusNode: null,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Phonenumber");
                    },
                    controller: phoneNumberController,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFieldLabel(text: "Password"),
                  CustomTextFormField(
                    focusNode: null,
                    validator: (value) {
                      return ValidationTextField.validateField(
                          value.toString(), "Password");
                    },
                    controller: passwordController,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  Row(
                    children: [
                      TextFieldLabel(text: "User Type"),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: BlocBuilder<DropDownCubit, DropDownState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              // key: _dropDown,
                              borderRadius: BorderRadius.zero,
                              value: userChoosed,
                              onChanged: (String? value) {
                                // Update the selected value when the dropdown changes
                                context.read<DropDownCubit>().change(context);
                                userChoosed = value ?? '';
                              },
                              items: <String>[
                                userTypeChoose[1],
                                userTypeChoose[0],
                              ].map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(value),
                                    ),
                                  );
                                },
                              ).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  SingleChildScrollView(
                    // controller: ScrollController(keepScrollOffset: true),
                    child: BlocBuilder<SignUpUserBloc, SignUpUserState>(
                      builder: (context, state) {
                        if (state is SignUpUserLoading) {
                          return CustomElevatedButton(
                              loading: true,
                              height: 57,
                              // width: 160,
                              text: "Signup",
                              onPressed: () async {},
                              alignment: Alignment.center);
                        }
                        return CustomElevatedButton(
                            height: 57,
                            // width: 160,
                            text: "Signup",
                            onPressed: () async {
                              LocationState state =
                                  context.read<LocationCubit>().state;
                              String location = '';
                              if (state is LocationLoaded) {
                                location = (state.location);
                              }
                              if (signUpFormKey.currentState!.validate()) {
                                context.read<SignUpUserBloc>().add(
                                    SignUpUserClickEvent(
                                        location: location,
                                        full_name: fullNameController.text,
                                        city: cityController.text,
                                        email: emailController.text,
                                        phonenumber: phoneNumberController.text,
                                        password: passwordController.text,
                                        user_type: userChoosed!));
                              }
                            },
                            alignment: Alignment.center);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            GeneratedRoute().onGeneratedRoute(
                              const RouteSettings(
                                  arguments: '', name: '/login'),
                            ));
                      },
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: "Ahready have an account? SignIn",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        )
                      ])))
                ]),
          )),
    );
  }
}
