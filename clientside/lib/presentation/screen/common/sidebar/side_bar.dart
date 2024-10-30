import 'package:bookme/constant/colors.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/common/get_token.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:bookme/presentation/screen/booking/booked_provider.dart';
import 'package:bookme/presentation/screen/common/custom_image.dart';
import 'package:bookme/presentation/screen/common/sidebar/menu_items.dart';
import 'package:bookme/presentation/screen/favorite_provider/favorite_provider_list.dart';
import 'package:bookme/presentation/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});
  // AnimationController _animationController=new AnimationController(vsync: );
  // StreamController<bool> isSidebarOpenedStreamController;
  // Stream<bool> isSidebarOpenedStream;
  // StreamSink<bool> isSidebarOpenedSink;
  // final _animationDuration = const Duration(milliseconds: 500);
  // @override
  // void initState() {
  //   super.initState();
  //   _animationController =
  //       AnimationController(vsync: this, duration: _animationDuration);
  //   isSidebarOpenedStreamController = PublishSubject<bool>();
  //   isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
  //   isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   isSidebarOpenedStreamController.close();
  //   isSidebarOpenedSink.close();
  //   super.dispose();
  // }
  // @override
  // void dispose() {
  //   // Cancel timers, stop animations, etc.
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    FetchProfileState state = context.read<FetchProfileBloc>().state;
    UserModel model = UserModel();
    if (state is FetchProfileLoadedState) {
      model = state.userModel;
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Row(
      children: <Widget>[
        Align(
          alignment: const Alignment(-10, 1),
          child: GestureDetector(
            onTap: () {
              // onIconPressed();
            },
            child: ClipPath(
              clipper: CustomMenuClipper(),
              child: Container(
                width: 40,
                // height: 500,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: ColorConstant.primary_color_dark(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    title: Text(
                      model.full_name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                    subtitle: Text(
                      model.email!,
                      style: const TextStyle(
                        color: Color(0xFF1BB5FD),
                        fontSize: 18,
                      ),
                    ),
                    leading: CircleAvatar(
                      child: CustomImage(
                        width: 100,
                        imagepath: model.profile!,
                      ),
                    ),
                  ),
                  Divider(
                    height: 64,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    indent: 32,
                    endIndent: 32,
                  ),
                  MenuItem(
                    icon: Icons.person,
                    title: "User Profile",
                    onTap: () {
                      Navigator.push(
                          context,
                          GeneratedRoute().onGeneratedRoute(RouteSettings(
                              arguments: {
                                'email': state.userModel.email,
                                'secret_code': state.userModel.secret_code
                              },
                              name: '/view_profile')));
                    },
                  ),
                  model.user_type == 'customer'
                      ? MenuItem(
                          icon: Icons.favorite_border,
                          title: "Favorite Providers",
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (builder) {
                              return FavProviderList(
                                key: key,
                              );
                            }));

                            // onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.HomePageClickedEvent);
                          },
                        )
                      : Container(),
                  MenuItem(
                    icon: Icons.shopping_basket,
                    title: "My Bookings",
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) {
                        return BookedProvider();
                      }));
                      // onIconPressed();
                      // BlocProvider.of<NavigationBloc>(context)
                      //     .add(NavigationEvents.HomePageClickedEvent);
                    },
                  ),
                  model.user_type == 'customer'
                      ? MenuItem(
                          icon: Icons.payment,
                          title: "Payment History",
                          onTap: () {
                            Navigator.push(
                                context,
                                GeneratedRoute().onGeneratedRoute(
                                    const RouteSettings(
                                        name: '/paymenthistory')));
                            // onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.HomePageClickedEvent);
                          },
                        )
                      : MenuItem(
                          icon: Icons.money,
                          title: "Income",
                          onTap: () {
                            // onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.HomePageClickedEvent);
                          }),
                  model.user_type == 'customer'
                      ? MenuItem(
                          icon: Icons.settings,
                          title: "Favorite Provider",
                          onTap: () {
                            // onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.HomePageClickedEvent);
                          },
                        )
                      : Container(),
                  MenuItem(
                    icon: Icons.settings,
                    title: "Settings",
                    onTap: () {
                      // onIconPressed();
                      // BlocProvider.of<NavigationBloc>(context)
                      //     .add(NavigationEvents.HomePageClickedEvent);
                    },
                  ),
                  model.user_type == 'customer'
                      ? MenuItem(
                          icon: Icons.change_circle,
                          title: "Be a provider",
                          onTap: () {
                            // onIconPressed();
                            // BlocProvider.of<NavigationBloc>(context)
                            //     .add(NavigationEvents.HomePageClickedEvent);
                          },
                        )
                      : Container(),
                  Divider(
                    height: 64,
                    thickness: 0.5,
                    color: Colors.white.withOpacity(0.3),
                    indent: 32,
                    endIndent: 32,
                  ),
                  MenuItem(
                    icon: Icons.settings,
                    title: "Setting",
                    onTap: () {
                      // onIconPressed();
                      // BlocProvider.of<NavigationBloc>(context)
                      //     .add(NavigationEvents.HomePageClickedEvent);
                    },
                  ),
                  MenuItem(
                    icon: Icons.exit_to_app,
                    title: "Logout",
                    onTap: () {
                      context.read<LogoutBloc>().add(
                          LogoutClickedEvent(token: getAccessToken(context)));
                      context.read<LoginBloc>().clear();
                      // context.read<FetchProfileBloc>().onChange(Change(
                      //     currentState: FetchProfileState(),
                      //     nextState: FetchProfileErrorState(message: "")));

                      // context.read<BookingBloc>().clear();
                      // context.read<SignUpUserBloc>().close();
                      snacbar(context, "Logout", "Successfully Logout!", true);

                      Navigator.push(
                        context,
                        GeneratedRoute().onGeneratedRoute(
                          const RouteSettings(arguments: '', name: '/login'),
                        ),
                      ); // onIconPressed();
                      // BlocProvider.of<NavigationBloc>(context)
                      //     .add(NavigationEvents.HomePageClickedEvent);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
