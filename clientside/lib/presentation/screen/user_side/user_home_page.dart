import 'package:bookme/constant/colors.dart';
import 'package:bookme/constant/server.dart';
import 'package:bookme/data/model/services_model.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_bloc.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_state.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/screen/common/app_bar.dart';
import 'package:bookme/presentation/screen/common/sidebar/side_bar.dart';
import 'package:bookme/presentation/screen/emergency/bottonsheet.dart';
import 'package:bookme/presentation/screen/emergency/view_providers_emergency.dart';
import 'package:bookme/presentation/widget/custom_elevated_button.dart';
import 'package:bookme/presentation/widget/error_fetching_widget.dart';
import 'package:bookme/theme.dart/custom_text_style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginState state = context.watch<LoginBloc>().state;
    String accessToken = '';

    if (state is LoginLoaded) {
      accessToken = state.loginModel.access.toString();
    }
    // ignore: avoid_single_cascade_in_expression_statements
    context
      ..read<FetchProfileBloc>().add(FetchProfileHit(newToken: accessToken));
    context
        .read<FetchBookingBloc>()
        .add(FetchBookingDetailsClickedEvent(token: getAccessToken(context)));
    return Scaffold(
      // key: scaffoldKey,
      endDrawer: const SideBar(),
      drawer: const Drawer(),
      appBar: CustomAppBarTop.customAppBar(context),
      // bottomNavigationBar: buildBottomNavigationBar(context, scaffoldKey),
      body: SingleChildScrollView(
        child: Container(
          color: ColorConstant.primary_color_dark(),
          child: SafeArea(
            child: Column(
              children: [
                buildFetchHomeBlocBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildFetchHomeBlocBuilder() {
  return BlocBuilder<FetchHomeBloc, FetchHomeState>(
    builder: (context, state) {
      if (state is FetchLoadingState) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(child: const CircularProgressIndicator()),
          ),
        );
      }
      if (state is FetchErrorState) {
        return buildFetchErrorStateWidget(state.message, context);
      }
      if (state is FetchLoadedState) {
        return Column(
          children: [
            Image.asset('assets/images/homepage.png'),
            buildFetchLoadedStateWidget(state),
            Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: buildMoreTextFieldLabel("More")),
            buildMoreRow(context),
          ],
        );
      }
      context.read<FetchHomeBloc>().add(FetchHomeHit());
      return buildMaterialButton(context);
    },
  );
}

Widget buildFetchErrorStateWidget(String message, BuildContext context) {
  return Container(
    color: Colors.white,
    height: MediaQuery.of(context).size.height,
    child: Center(
        child: Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ErrorFetchingData(
        btnName: "Retry",
        onPressed: () {
          context.read<FetchHomeBloc>().add(FetchHomeHit());
        },
        message: 'Please try again',
      ),
    )),
  );
}

Widget buildFetchLoadedStateWidget(FetchLoadedState state) {
  return Center(
    child: Column(
      children: [
        Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white),
            child: buildMoreTextFieldLabel("Services")),
        Container(
          padding: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: buildGridView(state.servicesModel),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

GridView buildGridView(List<ServicesModel> services) {
  return GridView.builder(
    dragStartBehavior: DragStartBehavior.down,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 18.0,
      mainAxisSpacing: 15.0,
    ),
    itemCount: services.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return buildInkWell(services[index], context);
    },
  );
}

InkWell buildInkWell(ServicesModel service, BuildContext context) {
  return InkWell(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white, // Set the background color to white
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      // padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "${ServerUrl.ipaddress()}/${service.image}",
            cacheHeight: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldLabel(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            text: service.service_name!,
          ),
        ],
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        GeneratedRoute().onGeneratedRoute(
          RouteSettings(
            arguments: [
              service.id.toString(),
              service.service_name,
            ],
            name: '/serviceproviderview',
          ),
        ),
      );
    },
  );
}

Widget buildMaterialButton(BuildContext context) {
  return MaterialButton(
    onPressed: () {
      context.read<FetchHomeBloc>().add(FetchHomeHit());
    },
    child: const Text("Call Api"),
  );
}

Widget buildMoreTextFieldLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 15,
      right: 15,
      top: 10,
    ),
    child: TextFieldLabel(
      text: text,
      colorr: ColorConstant.primary_color_dark(),
      fontsize: 21,
      padding: const EdgeInsets.all(0),
    ),
  );
}

Widget buildMoreRow(BuildContext context) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildContainer(
              "assets/images/bid/addbid.png", "Add bid", '/add_bid', context),
          buildContainer(
              "assets/images/siren.png", "Emergency", '/emergency', context),
          buildContainer("assets/images/booksymbol.png", "Booking",
              '/view_booking', context),
        ],
      ),
    ),
  );
}

InkWell buildContainer(
    String assetPath, String label, String routeName, BuildContext context) {
  return InkWell(
      child: Container(
        // width: Media.
        padding: const EdgeInsets.all(5),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white, // Set the background color to white
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 7, // Blur radius
              offset: const Offset(0, 3), // Offset of the shadow
            ),
          ],
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              assetPath,
              cacheHeight: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldLabel(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              text: label,
            ),
          ],
        ),
      ),
      onTap: () {
        if (routeName == '/emergency') {
          String userChosen = '';
          String defaultChoose = '';
          List<String> services = [];
          buttonModelSheet(
            context,
          );
          return;
        }
        // s.read<FetchBookingBloc>().emit(FetchBookingInitial());
        Navigator.push(
          context,
          GeneratedRoute().onGeneratedRoute(
            RouteSettings(
              // arguments: [],
              name: routeName,
            ),
          ),
        );
      });
}
