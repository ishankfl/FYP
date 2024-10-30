import 'package:bookme/data/model/services_model.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_bloc.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_event.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_state.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/emergency/view_providers_emergency.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:flutter/material.dart';

// Future<dynamic> buttonModelSheet(
//   BuildContext context,
// ) {
//   List<String> services;
//   String? userChosen;
//   String defaultChoosed = '';
//   return showModalBottomSheet(
//     context: context,
//     builder: (builder) {
//       return Container(
//         height: 400,
//         // width: MediaQuery.of(context).size.width - 50,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(20.0),
//             topRight: Radius.circular(20.0),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 'Choose A Service',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               Align(
//                 // alignment: Alignment.centerLeft,
//                 child: Container(
//                   height: 50,
//                   width: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 1),
//                   ),
//                   child: BlocBuilder<DropDownCubit, DropDownState>(
//                     builder: (context, state) {
//                       return Align(
//                         alignment: Alignment.centerLeft,
//                         child: Container(
//                           height: 50,
//                           width: 150,
//                           decoration: BoxDecoration(
//                             border: Border.all(width: 1),
//                           ),
//                           child: BlocBuilder<FetchHomeBloc, FetchHomeState>(
//                             builder: (context, state) {
//                               if (state is FetchLoadedState) {
//                                 services = state.servicesModel
//                                     .map((service) => service.service_name!)
//                                     .toList();
//                                 defaultChoosed =
//                                     state.servicesModel[0].service_name!;

//                                 return DropdownButton<String>(
//                                   value: userChosen ?? services.first,
//                                   onChanged: (String? value) {
//                                     context
//                                         .read<DropDownCubit>()
//                                         .change(context);
//                                     userChosen = value!;
//                                   },
//                                   items: services.map<DropdownMenuItem<String>>(
//                                     (String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Container(
//                                           padding: const EdgeInsets.all(10),
//                                           child: Text(value),
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                 );
//                               }
//                               context.read<FetchHomeBloc>().add(FetchHomeHit());
//                               return ErrorFetchingData(
//                                 message: "Error to connect to the server",
//                                 btnName: "Retry",
//                                 onPressed: () {
//                                   // context
//                                   //     .read<FetchHomeBloc>()
//                                   //     .add(FetchHomeH it());
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               CustomElevatedButton(
//                 text: "Next",
//                 width: 200,
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (builder) {
//                     return ViewEmergencyProvider(
//                       name: userChosen!=null ?userChosen!:defaultChoosed,
//                     );
//                   }));
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

Future<dynamic> buttonModelSheet(BuildContext context) {
  List<ServicesModel> services = [];
  ServicesModel? selectedService;
  String defaultChoosed = '';
  return showModalBottomSheet(
    context: context,
    builder: (builder) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Choose A Service',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                  ),
                  child: BlocBuilder<FetchHomeBloc, FetchHomeState>(
                    builder: (context, state) {
                      if (state is FetchLoadedState) {
                        services = state.servicesModel;
                        selectedService = services[0];
                        return DropdownButton<ServicesModel>(
                          value: selectedService,
                          onChanged: (ServicesModel? value) {
                            context.read<FetchHomeBloc>().add(FetchHomeHit());
                            if (value != null) {
                              selectedService = value;
                            }
                          },
                          items: services.map<DropdownMenuItem<ServicesModel>>(
                            (ServicesModel service) {
                              return DropdownMenuItem<ServicesModel>(
                                value: service,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(service.service_name!),
                                ),
                              );
                            },
                          ).toList(),
                        );
                      }
                      context.read<FetchHomeBloc>().add(FetchHomeHit());
                      return ErrorFetchingData(
                        message: "Error connecting to the server",
                        btnName: "Retry",
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              CustomElevatedButton(
                text: "Next",
                width: 200,
                onPressed: () {
                  if (selectedService != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) {
                        return ViewEmergencyProvider(
                          // key: ,

                          // : selectedService!.id,
                          name: selectedService!,
                        );
                      }),
                    );
                  } else {
                    // Handle case where no service is selected
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
