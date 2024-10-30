import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/screen/bid/bid_list.dart';
import 'package:bookme/presentation/screen/chat/chat_list.dart';
import 'package:bookme/presentation/screen/common/sidebar/side_bar.dart';
import 'package:bookme/presentation/screen/service_providerside/provider_home.dart';
import 'package:bookme/presentation/screen/user_side/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  
  List<dynamic> listReturn(BuildContext context) {
    LoginState stateofLogin = context.read<LoginBloc>().state;
    String userType = '';
    if (stateofLogin is LoginLoaded) {
      userType = stateofLogin.loginModel.user_type!;
    }

    List<dynamic> screens = [
      userType == 'customer' ? const UserHomePage() : const ProviderHome(),
    const BidList(),
    const ChatUserList(),
      // const SideBar()
  ];
    return screens;
  }
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        endDrawer: const SideBar(),
        key: scaffoldKey,
        body: BlocBuilder<NavigationCubit, NavigationState>(
            builder: (context, state) {
          return listReturn(context)[state.index];
        }),
        bottomNavigationBar: Container(
          // alignment: Alignment.bottomCenter,
          color: ColorConstant.primary_color_dark(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: GNav(
                backgroundColor: ColorConstant.primary_color_dark(),
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: ColorConstant.secondary_color_blue(),
                gap: 8,
                padding: const EdgeInsets.only(
                    left: 8, right: 8, bottom: 12, top: 12),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                    onPressed: () {
                      context.read<NavigationCubit>().changePage(index: 0);
                    },
                  ),
                  GButton(
                    icon: Icons.shop_two,
                    text: 'Bid',
                    onPressed: () {
                      context.read<NavigationCubit>().changePage(index: 1);
                    },
                  ),
                  GButton(
                    icon: Icons.chat_bubble,
                    text: 'Chat',
                    onPressed: () {
                      context.read<NavigationCubit>().changePage(index: 2);
                    },
                  ),
                  GButton(
                    icon: Icons.settings,
                    text: 'Profile',
                    onPressed: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),
                ]),
          ),
        ));
  }
}
