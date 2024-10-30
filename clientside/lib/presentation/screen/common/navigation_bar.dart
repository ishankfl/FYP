import 'package:bookme/constant/colors.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/screen/chat/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

Container buildBottomNavigationBar(
    BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  return Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(bottom: 20),
    color: ColorConstant.primary_color_dark(),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: GNav(
          backgroundColor: ColorConstant.primary_color_dark(),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: ColorConstant.secondary_color_blue(),
          gap: 8,
          padding:
              const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 12),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {},
            ),
            GButton(
              icon: Icons.shop_two,
              text: 'Bid',
              onPressed: () {
                Navigator.push(
                    context,
                    GeneratedRoute().onGeneratedRoute(
                        const RouteSettings(name: '/bid_list')));
              },
            ),
            GButton(
              icon: Icons.chat_bubble,
              text: 'Chat',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatUserList(),
                    ));
              },
            ),
            GButton(
              icon: Icons.settings,
              text: 'Profile',
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
                // scaffoldKey.currentState?.openDrawer();
              },
            ),
          ]),
    ),
  );
}
