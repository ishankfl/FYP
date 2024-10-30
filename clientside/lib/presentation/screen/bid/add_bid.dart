import 'dart:io';
import 'package:bookme/constant/colors.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/widget/custom_backscreen_btn_appbar.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/presentation/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/date_time_choosen.dart';
import 'package:bookme/presentation/widget/location_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';

// ignore: must_be_immutable
class BidAdd extends StatelessWidget {
  BidAdd({super.key});

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool loading = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = DateTime(picked.year, picked.month, picked.day);
      // ignore: use_build_context_synchronously
      context.read<DateCubit>().addition(date: selectedDate);
    }
    // ignore: use_build_context_synchronously
    context.read<DateCubit>().addition(date: selectedDate);
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      // ignore: use_build_context_synchronously
      context.read<TimeCubit>().addition(time: selectedTime);
    }
  }

  Future<List<File>> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile == null) {
      return [];
    }
    File profileFile = File(pickedFile.path);
    return [profileFile];
  }

  final loginFormKey = GlobalKey<FormState>();

  List<String> services = [];
  String? userChosen;
  TextEditingController contentEditingController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int selectedServiceId = 0;
  @override
  Widget build(BuildContext context) {
    List<File>? images;
    return Scaffold(
      backgroundColor: ColorConstant.prmary_color_notdart(),
      appBar: backBtnAppbar("Add bid"),
      body: SafeArea(
        child: BlocListener<AddBidBloc, AddBidState>(
          listener: (context, state) {
            if (state is AddBidError) {
              print("error onadd bid");
              snacbar(context, "Error", state.message!, false);
            }
            if (state is AddBidSuccess) {
              Navigator.push(
                  context,
                  GeneratedRoute()
                      .onGeneratedRoute(const RouteSettings(name: "/bidlist")));
            }
          },
          child: Form(
            key: loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ColorConstant.prmary_color_notdart()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DateTimeWidget.DateTimeShowWidget(
                          selectDate,
                          selectedDate,
                          selectTime,
                          selectedTime,
                        ),
                        const SizedBox(height: 10),
                        const LocationWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  TextFieldLabel(
                                    text: "Service Type:",
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                      right: 0,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1),
                                          ),
                                          child: BlocBuilder<DropDownCubit,
                                              DropDownState>(
                                            builder: (context, state) {
                                              return Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                      height: 50,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1)),
                                                      child: BlocBuilder<
                                                          FetchHomeBloc,
                                                          FetchHomeState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is FetchLoadedState) {
                                                            services = state
                                                                .servicesModel
                                                                .map((service) =>
                                                                    service
                                                                        .service_name!)
                                                                .toList();
                                                            return DropdownButton<
                                                                String>(
                                                              value:
                                                                  userChosen ??
                                                                      services
                                                                          .first,
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                context
                                                                    .read<
                                                                        DropDownCubit>()
                                                                    .change(
                                                                        context);
                                                                userChosen =
                                                                    value;
                                                                // Find the service ID based on the selected service name
                                                                selectedServiceId =
                                                                    services.indexWhere((service) =>
                                                                        service ==
                                                                        userChosen);
                                                                print(
                                                                    userChosen);
                                                              },
                                                              items: services.map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                                (value) {
                                                                  return DropdownMenuItem<
                                                                      String>(
                                                                    value:
                                                                        value,
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                      child: Text(
                                                                          value),
                                                                    ),
                                                                  );
                                                                },
                                                              ).toList(),
                                                            );
                                                          }
                                                          context
                                                              .read<
                                                                  FetchHomeBloc>()
                                                              .add(
                                                                  FetchHomeHit());
                                                          return const Text(
                                                              "Hello");
                                                        },
                                                      )));
                                            },
                                          )))
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  TextFieldLabel(
                                    text: "Amount: ",
                                    padding: const EdgeInsets.all(0),
                                  ),
                                  const SizedBox(
                                    width: 47,
                                  ),
                                  CustomTextFormField(
                                    controller: amountController,
                                    width: 200,
                                    hintText: "Desired amount",
                                    // key: formKey,
                                    onChanged: (value) {},
                                    validator: (value) {
                                      try {
                                        if (value == "") {
                                          return "Must fill the form";
                                        }
                                        int newvalue =
                                            int.parse(value.toString());
                                      } catch (value) {
                                        return "Amount must be integer";
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              TextFieldLabel(
                                text: "Bid Content",
                                padding: const EdgeInsets.all(0),
                              ),
                              TextField(
                                // keyboardType: TextInputType.multiline,
                                maxLines: 2,
                                controller: contentEditingController,
                                onChanged: (value) {
                                  contentEditingController.text = value;
                                },

                                autofillHints: const ["Add Content"],
                              ),
                              const SizedBox(height: 25),
                              TextFieldLabel(
                                text: "Select Image:",
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  top: 5,
                                  bottom: 10,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  images =
                                      await _pickImage(ImageSource.gallery);
                                  if (images!.isEmpty) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("You need to add an image")),
                                    );
                                    return;
                                  }
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<StoreImageCubit>()
                                      .addition(image: images![0]);
                                },
                                child:
                                    BlocBuilder<StoreImageCubit, ImageStorage>(
                                  builder: (context, state) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: state.image != null
                                          ? Image.file(
                                              state.image!,
                                              cacheHeight: 200,
                                              cacheWidth: 300,
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/images/photoupload.jpg',
                                                cacheHeight: 100,
                                              ),
                                            ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 25),
                              BlocBuilder<AddBidBloc, AddBidState>(
                                builder: (context, state) {
                                  return BlocBuilder<LocationCubit,
                                      LocationState>(
                                    builder: (context, state2) {
                                      return CustomElevatedButton(
                                          loading: state is AddBidLoading,
                                          text: "Add",
                                          width: 120,
                                          height: 50,
                                          onPressed: () async {
                                            if (loginFormKey.currentState!
                                                .validate()) {
                                              String token =
                                                  getAccessToken(context);
                                              String path;
                                              if (context
                                                      .read<StoreImageCubit>()
                                                      .state
                                                      .image !=
                                                  null) {
                                                path = context
                                                    .read<StoreImageCubit>()
                                                    .state
                                                    .image!
                                                    .path;
                                              } else {
                                                path = "";
                                              }
                                              print(selectedServiceId);

                                              if (state2 is LocationLoaded) {
                                                print(userChosen);

                                                context.read<AddBidBloc>().add(
                                                    AddBidClickedEvent(
                                                        amount: amountController
                                                            .text
                                                            .trim(),
                                                        service:
                                                            selectedServiceId +
                                                                1,
                                                        textcontent:
                                                            contentEditingController
                                                                .text,
                                                        image: path,
                                                        lon: state2.lonlag[0],
                                                        lat: state2.lonlag[1],
                                                        location: context
                                                            .read<
                                                                LocationCubit>()
                                                            .showAddressByPoint(
                                                                state2
                                                                    .lonlag[0],
                                                                state2
                                                                    .lonlag[1])
                                                            .toString(),
                                                        token: token));
                                              }
                                            }
                                          });
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
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
}
