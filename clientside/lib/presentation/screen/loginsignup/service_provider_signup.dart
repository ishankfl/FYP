// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

// ignore: must_be_immutable
class ServiceProviderSignup extends StatelessWidget {
  File? profileFile;
  File? certyficateFile;
  // File? _imageFile;
  List<File>? imagesCertificate;
  List<File>? imagesProfile;
  TextEditingController experienceController = TextEditingController();

  Future<List> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    // print(_imageFile);
    if (pickedFile == null) {
      return [];
    }
    imagesProfile?.add(File(pickedFile.path));
    profileFile = File(pickedFile.path);

    return [File(pickedFile.path)];
  }

  Future<List> _pickCertifcate(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) {
      return [];
    }
    imagesCertificate?.add(File(pickedFile.path));
    certyficateFile = File(pickedFile.path);

    return [File(pickedFile.path)];
  }

  List<FilePickerResult>? files;

  List<String> services = [];
  ServiceProviderSignup({super.key, required data});
  String defaultChoosed = '';
  String? userChosen;

  @override
  Widget build(BuildContext context) {
    // experienceController.text = '16';
    return BlocListener<ProviderSignupUserBloc, ProviderSignupUserState>(
        listener: (context, state) {
          if (state is ProviderSignupUserLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Successfully Provider Registered',
              ),
              duration: Duration(seconds: 1),
            ));
            Navigator.push(
                context,
                GeneratedRoute().onGeneratedRoute(
                    const RouteSettings(arguments: '', name: '/login')));
          }
          if (state is ProviderSignupUserError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                '${state.message}',
              ),
              duration: const Duration(seconds: 1),
            ));
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Form(
              child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: LoginSignUpTitle(
                        context: context,
                        text: "Signup with provider",
                        fontsize: 19,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldLabel(text: "Service Type"),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                        child: BlocBuilder<DropDownCubit, DropDownState>(
                          builder: (context, state) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                ),
                                child:
                                    BlocBuilder<FetchHomeBloc, FetchHomeState>(
                                  builder: (context, state) {
                                    if (state is FetchLoadedState) {
                                      services = state.servicesModel
                                          .map((service) =>
                                              service.service_name!)
                                          .toList();
                                      defaultChoosed =
                                          state.servicesModel[0].service_name!;

                                      return DropdownButton<String>(
                                        value: userChosen ?? services.first,
                                        onChanged: (String? value) {
                                          context
                                              .read<DropDownCubit>()
                                              .change(context);
                                          userChosen = value;
                                        },
                                        items: services
                                            .map<DropdownMenuItem<String>>(
                                          (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(value),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      );
                                    }
                                    context
                                        .read<FetchHomeBloc>()
                                        .add(FetchHomeHit());
                                    return ErrorFetchingData(
                                      message: "Error to connect to the server",
                                      btnName: "Retry",
                                      onPressed: () {
                                        context
                                            .read<FetchHomeBloc>()
                                            .add(FetchHomeHit());
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFieldLabel(text: "Experience"),

                    CustomTextFormField(
                      hintText: "Please enter your experience",
                      fillColor: Colors.red,
                      controller: experienceController,
                    ), // DropdownButton<String>(

                    const SizedBox(height: 22),
                    TextFieldLabel(text: "Profile Picture"),
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 4,
                      // width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              List image =
                                  await _pickImage(ImageSource.gallery);
                              if (image.isEmpty) {
                                snacbar(context, "Image required",
                                    "Please add an image", false);
                              }
                              context
                                  .read<StoreImageCubit>()
                                  .addition(image: image[0]);
                              imagesProfile?.add(File(image[0]));
                            },
                            child: BlocBuilder<StoreImageCubit, ImageStorage>(
                              builder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: state.image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.file(
                                            state.image!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/loginsignup/unknown.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: FloatingActionButton(
                              onPressed: () async {
                                List image =
                                    await _pickImage(ImageSource.gallery);
                                if (image.isNotEmpty) {
                                  context
                                      .read<StoreImageCubit>()
                                      .addition(image: image[0]);
                                  imagesCertificate?.add(File(image[0]));
                                }
                                // profileFile = imagesCertificate![0];
                              },
                              backgroundColor: Colors.blue,
                              child: const Icon(Icons.upload),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFieldLabel(
                      text: "Certificate",
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height / 4,
                      // width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          InkWell(onTap: () async {
                            List image =
                                await _pickCertifcate(ImageSource.gallery);
                            // print(image);
                            if (image.isEmpty) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("You neeed to add an image")));
                              return;
                            }
                            certyficateFile = (image[0]);
                            context
                                .read<CertificateStoreImageCubit>()
                                .addition(image: image[0]);
                            imagesCertificate?.add(File(image[0]));
                          }, child: BlocBuilder<CertificateStoreImageCubit,
                                  CertificateImageStorage>(
                              builder: (context, state) {
                            return Container(
                              height: 200,
                              child: Container(
                                  child: state.image != null
                                      ? Image.file(state.image!)
                                      : Image.asset(
                                          width: 300,
                                          height: 300,
                                          'assets/loginsignup/uploadfiles.png')),
                            );
                          })),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: FloatingActionButton(
                              onPressed: () async {
                                List image =
                                    await _pickCertifcate(ImageSource.gallery);
                                // print(image);
                                if (image.isEmpty) {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "You neeed to add an image")));
                                  return;
                                }
                                // certyficateFile = File(image[0]);
                                // ignore: use_build_context_synchronously
                                context
                                    .read<CertificateStoreImageCubit>()
                                    .addition(image: image[0]);
                                imagesCertificate?.add(File(image[0]));
                              },
                              backgroundColor: Colors.blue,
                              child: const Icon(
                                Icons.upload,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 22,
                    ),

                    CustomElevatedButton(
                        text: "Verify",
                        height: 57,
                        width: 157,
                        // ignore: curly_braces_in_flow_control_structures
                        onPressed: () {
                          VerificationState state =
                              context.read<VerificationBloc>().state;
                          String email = '';
                          if (state is VerificationLoaded) {
                            email = state.verifyModel.email!;
                          }
                          // VerificationLoaded model=;
                          // certyficateFile.path;
                          print("Nullssl");

                          if (certyficateFile == null || profileFile == null) {
                            snacbar(
                                context, "Required", "Please add image ", true);
                            return;
                          }
                          if (userChosen == null || userChosen == '') {
                            userChosen = defaultChoosed;
                          }
                          if (experienceController.text == '') {
                            snacbar(context, "Required",
                                "Please add experience ", true);
                            return;
                          }

                          context
                              .read<ProviderSignupUserBloc>()
                              .add(ProviderSignupUserClickEvent(
                                email: email,
                                certificate: certyficateFile,
                                profile: profileFile,
                                experience: experienceController.text,
                                service_type: userChosen ?? defaultChoosed,
                              ));
                          // if (_formKey.currentState!.validate()) {
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
            ),
          )),
        ));
  }
}
