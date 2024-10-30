// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/screen/booking/viewrequestwidget.dart';
import 'package:flutter/material.dart';

class ViewBooking extends StatefulWidget {
  const ViewBooking({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserSideViewBookingState createState() => _UserSideViewBookingState();
}

class _UserSideViewBookingState extends State<ViewBooking> {
  int selectedTabIndex = 0; // Keep track of the selected tab index
  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    List<List<String>> btnsList;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoaded) {
          if (state.loginModel.user_type == 'customer') {
            btnsList = [
              ["Chat", "Location"],
              ["Reschedule", "Cancel"],
              ["Payment", "View Details"]
            ];
          } else {
            btnsList = [
              ["Chat", "Complete"],
              ["Accept", "Cancel"],
              ["View Payment", "View Details"]
            ];
          }

          return ViewRequestWidget(btns: btnsList);
        }
        return Text("I got error here");
      },
    );
  }
}
