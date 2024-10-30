import 'dart:io';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  get passwordController => null;

  @override
  Widget build(BuildContext context) {
    LoginState state = context.watch<LoginBloc>().state;
    String accesstoken = '';
    if (state is LoginLoaded) {
      accesstoken = state.loginModel.access.toString();
      print(accesstoken);
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: ColorConstant.prmary_color_notdart(),
          title:
              TextFieldLabel(text: "Edit Profile", padding: EdgeInsets.all(0)),
        ),
        body: SafeArea(child: BlocBuilder<FetchProfileBloc, FetchProfileState>(
            builder: (context, state) {
          if (state is FetchProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchProfileErrorState) {
            return const Text("error");
          }
          if (state is FetchProfileLoadedState) {
            File? imageFile;
            List<File>? images;
            String imagesendpath = '';

            Future<List> pickImage(ImageSource source) async {
              final pickedFile = await ImagePicker().pickImage(source: source);
              // print(_imageFile);
              if (pickedFile == null) {
                return [];
              }
              print("Path of file");
              print(pickedFile.path);
              imagesendpath = pickedFile.path;
              return [File(pickedFile.path)];
            }

            // if()
            String imagepath = state.userModel.profile.toString();
            if (imagepath != "") {
              imagepath = imagepath.substring(1);
            }
            var userNameController = TextEditingController();
            var fullNameController = TextEditingController();
            var emailController = TextEditingController();
            var cityController = TextEditingController();
            var phoneNumberController = TextEditingController();
            if (state.userModel.username == null) {
              userNameController.text = '';
            } else {
              userNameController.text = state.userModel.username.toString();
            }
            fullNameController.text = state.userModel.full_name.toString();
            emailController.text = state.userModel.email.toString();
            cityController.text = state.userModel.city.toString();
            phoneNumberController.text = state.userModel.phonenumber.toString();
            context.read<StoreImageCubit>().clear();
            return Center(
                child: SingleChildScrollView(
              child: Form(
                  // key: signUpFormKey,
                  child: Container(
                width: double.maxFinite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 34),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          List image = await pickImage(ImageSource.gallery);
                          if (image.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("You neeed to add an image")));
                            return;
                          }
                          context
                              .read<StoreImageCubit>()
                              .addition(image: image[0]);
                        },
                        child: BlocBuilder<StoreImageCubit, ImageStorage>(
                          builder: (context, state) {
                            return Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: imagepath != ""
                                    ? state.image == null
                                        ? ClipOval(
                                            child: Image.network(
                                              // state.image!,
                                              ServerUrl.ipaddress() + imagepath,
                                              cacheHeight: 100,
                                              cacheWidth: 100,
                                              // cacheHeight: 100,
                                              // fit: BoxFit.,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.file(
                                              state.image!,
                                              cacheHeight: 100,
                                              cacheWidth: 100,
                                              // cacheHeight: 100,
                                              // fit: BoxFit.,
                                            ),
                                          )
                                    : state.image != null
                                        ? ClipOval(
                                            child: Image.file(
                                              state.image!,
                                              cacheHeight: 100,
                                              cacheWidth: 100,
                                              // cacheHeight: 100,
                                              // fit: BoxFit.,
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                                cacheHeight: 100,
                                                cacheWidth: 100,
                                                ServerUrl.ipaddress() +
                                                    "media/emptyimage/empyt.jpg"),
                                          ));
                          },
                        ),
                      ),
                      // Image.network(
                      //   ServerUrl.ipaddress() + imagepath,
                      //   height: 100,
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: LoginSignUpTitle(
                          context: context,
                          text: "Edit Your Profile",
                          fontsize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldLabel(
                        text: "User Name",
                      ),
                      CustomTextFormField(
                        focusNode: null,
                        validator: (value) {
                          return ValidationTextField.validateField(
                              value.toString(), "Username");
                        },
                        controller: userNameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldLabel(
                        text: "Full Name",
                      ),
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

                      TextFieldLabel(
                        text: "Phone number",
                      ),
                      CustomTextFormField(
                        focusNode: null,
                        validator: (value) {
                          return ValidationTextField.validateField(
                              value.toString(), "Phone number");
                        },
                        controller: phoneNumberController,
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
                      state.userModel.user_type == 'provider'
                          ? Column(
                              children: [
                                TextFieldLabel(text: "City"),
                                CustomTextFormField(
                                  focusNode: null,
                                  validator: (value) {
                                    return ValidationTextField.validateField(
                                        value.toString(), "City");
                                  },
                                  controller: cityController,
                                ),
                              ],
                            )
                          : Text(state.userModel.user_type!),

                      const SizedBox(
                        height: 20,
                      ),

                      SingleChildScrollView(
                        // controller: ScrollController(keepScrollOffset: true),
                        child: CustomElevatedButton(
                            height: 57,
                            width: 160,
                            text: "Edit",
                            onPressed: () async {
                              UserModel model = UserModel();
                              model.email = emailController.text;
                              model.profile = imagesendpath;
                              model.city = cityController.text;
                              model.full_name = fullNameController.text;
                              model.phonenumber = phoneNumberController.text;
                              model.username = userNameController.text;
                              model.access = accesstoken;

                              context
                                  .read<SignUpUserBloc>()
                                  .add(UpdateUserClickEvent(model: model));
                            },
                            alignment: Alignment.center),
                      ),
                    ]),
              )),
            ));
          }
          context
              .read<FetchProfileBloc>()
              .add(FetchProfileHit(newToken: accesstoken));
          // 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA3MDYxNzQzLCJpYXQiOjE3MDcwNTU3NDMsImp0aSI6ImQ2ZDZhYTg2ZTk3ZjRjNjlhNWI3NGZkNTlkOTZiMmY0IiwidXNlcl9pZCI6OH0.6mjds3cboE_053JKErBrIcRyhC1dBFczisKPHtHylr8'));
          return MaterialButton(
            onPressed: () {
              context.read<FetchHomeBloc>().add(FetchHomeHit());
            },
            child: const Text("Call APi"),
          );
        })));
  }
}
