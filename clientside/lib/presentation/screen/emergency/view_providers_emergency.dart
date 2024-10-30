// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_bloc.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_event.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_state.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/screen/booking/service_provider_page.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewEmergencyProvider extends StatelessWidget {
  const ViewEmergencyProvider({
    Key? key,
    required this.name,
  }) : super(key: key);
  // final String name;
  final ServicesModel name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<FetchEmergencyProviderBloc,
            FetchEmergencyProviderState>(
          builder: (context, state) {
            if (state is FetchEmergencyProviderLoadedState) {
              List<ServiceProviderModel> model = state.providerModel;
              return Container(
                child: Column(children: [
                  ServiceProviderListView(
                    providerModel: model,
                    serviceType: name,
                    isEmergency: true,
                  )
                ]),
              );
            }
            if (state is FetchEmergencyProviderErrorState) {
              return Container(
                child: Center(
                  child: Column(
                    children: [],
                  ),
                ),
              );
            }
            if (state is FetchEmergencyProviderErrorState) {
              return Container(
                child: Center(
                  child: Column(
                    children: [],
                  ),
                ),
              );
            }
            context.read<FetchEmergencyProviderBloc>().add(
                FetchEmergencyProviderHit(
                    newToken: getAccessToken(context),
                    serviceName: name.service_name!));
            return ErrorFetchingData(
              btnName: "Try again",
              message: "Error to fetch data",
              onPressed: () {},
            );
          },
        ),
      ),
    );
  }
  //   context.read<FetchEmergencyProviderBloc>().add(FetchEmergencyProviderHit(
  //       newToken: getAccessToken(context), serviceName: userChosen!));
  // }
}
