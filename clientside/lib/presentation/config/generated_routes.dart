import 'package:bookme/data/model/service_provider_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/screen/bid/bid_list.dart';
import 'package:bookme/presentation/screen/common/home_page.dart';
import 'package:bookme/presentation/screen/common/network_connection_failpage.dart';
import 'package:bookme/presentation/screen/loginsignup/forgot_change_password.dart';
import 'package:bookme/presentation/screen/loginsignup/view_profile.dart';
import 'package:bookme/presentation/screen/loginsignup/login.dart';
import 'package:bookme/presentation/screen/loginsignup/service_provider_signup.dart';
import 'package:bookme/presentation/screen/loginsignup/user_signup.dart';
import 'package:bookme/presentation/screen/loginsignup/verifycation.dart';
import 'package:bookme/presentation/screen/payment/view_payment_history.dart';
import 'package:bookme/presentation/screen/bid/add_bid.dart';
import 'package:bookme/presentation/screen/booking/booking_page.dart';
import 'package:bookme/presentation/screen/booking/service_provider_page.dart';
import 'package:bookme/presentation/screen/booking/view_booking.dart';
import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';

class GeneratedRoute {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return logicLgin();
      case "/serviceproviderview":
        return MaterialPageRoute(
            builder: (_) => ServiceProviderDetailView(
                args: routeSettings.arguments as List));
      case "/bid_list":
        return MaterialPageRoute(builder: (_) => const BidList());
      case "/paymenthistory":
        return MaterialPageRoute(builder: (_) => const PaymentHistory());
      case "/login":
        return MaterialPageRoute(builder: (_) => CommonDetailsLogin());
      case "/user_signup":
        return MaterialPageRoute(builder: (_) => UserSignUp());
      case "/verify_account":
        return MaterialPageRoute(
            builder: (_) => AccountVerification(
                  args: routeSettings.arguments as Map,
                ));
      case "/forgot_password_change":
        return MaterialPageRoute(
            builder: (_) => ChangePasswordScreen(
                  args: routeSettings.arguments as Map,
                ));
      case "/user_homepage":
        return MaterialPageRoute(builder: (_) => HomePage());
      case "/provider_homepage":
        return MaterialPageRoute(builder: (_) => HomePage());

      case "/service_provider_signup":
        return MaterialPageRoute(
            builder: (_) =>
                ServiceProviderSignup(data: routeSettings.arguments as Map));
      case "/viewprofile":
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case "/booking_time_selection":
        return MaterialPageRoute(
            builder: (_) => BookingTimeDetails(
                model: routeSettings.arguments as ServiceProviderModel));
      // case "/view_booking":
      //   return MaterialPageRoute(
      //       builder: (_) => ViewRequestWidget(
      //             btns: routeSettings.arguments as List<List<String>>,
      //           ));
      case "/add_bid":
        return MaterialPageRoute(builder: (_) => BidAdd());
      case "/bidlist":
        return MaterialPageRoute(builder: (_) => const BidList());
      case "/view_booking":
        return MaterialPageRoute(builder: (_) => const ViewBooking());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              children: [
                Text("This route ${routeSettings.name} doesn't exist")
              ],
            ),
          ),
        );
    }
  }

  MaterialPageRoute<dynamic> logicLgin() {
    return MaterialPageRoute(
      builder: (context) {
        context.read<LocationCubit>().showAddress();

        try {
          var loginState = context.read<LoginBloc>().state;
          if (loginState is LoginLoaded) {
            if (loginState.loginModel.user_type == "customer") {
              return BlocBuilder<ConnectivityBloc, ConnectivityState>(
                builder: (context, state) {
                  if (state is ConnectivitySuccessState) {
                    return HomePage();
                  }
                  return const NetworkFailPage();
                },
              );
            } else {
              return BlocBuilder<ConnectivityBloc, ConnectivityState>(
                builder: (context, state) {
                  if (state is ConnectivitySuccessState) {
                    return HomePage();
                  }
                  return const NetworkFailPage();
                },
              );
              // Navigator.push(
            }
          }
          return CommonDetailsLogin();
        } catch (ees) {
          return CommonDetailsLogin();
        }
      },

      //
    );
  }
}
