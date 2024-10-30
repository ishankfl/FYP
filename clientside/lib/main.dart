import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/repository/authetication/forgot_password_repo.dart';
import 'package:bookme/data/repository/authetication/logout_repo.dart';
import 'package:bookme/data/repository/favorite_provider_repo.dart';
import 'package:bookme/data/repository/notification_repo.dart';
import 'package:bookme/data/repository/provider_home.dart';
import 'package:bookme/data/repository/repo_export.dart';
import 'package:bookme/data/repository/review_rate_repo.dart';
import 'package:bookme/logic/bloc/emergency/emergency_providers/emergency_providers_bloc.dart';
import 'package:bookme/logic/bloc/favorite_provider/fetch_fav_provider_bloc.dart';
import 'package:bookme/logic/bloc/favorite_provider/make_favorite_bloc.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/logic/cubit/location/location_focus_cubit.dart';
import 'package:bookme/logic/services/device_info.dart';
import 'package:bookme/notification_services.dart';
import 'package:bookme/presentation/config/generated_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_bloc/connectivity_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDVC2CiDD3eNQjJwYpS9l4dfiyHVJMdOVA',
          appId: '1:462221960937:android:bd3e892e085cd6f38d3278',
          messagingSenderId: '462221960937',
          projectId: 'flutter-notification-f38aa'));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterNativeSplash.remove();

  runApp(const MainWidget());
}

class MainWidget extends StatefulWidget {
  const MainWidget({
    super.key,
  });

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    DeviceInfo.androidInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IndexCubit(),
        ),
        BlocProvider(
          create: (context) => FetchEmergencyProviderBloc(),
        ),
        BlocProvider(
          create: (context) =>
              LoginBloc(apiRepository: LoginRepository(), rememberMe: true),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              SignUpUserBloc(apiRepository: SignUpUserRepository()),
        ),
        BlocProvider(
          create: (context) =>
              ProviderSignupUserBloc(apiRepository: ProviderSignupRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              ForgotPasswordBloc(apiRepository: ForgotPasswordRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              ChangePasswordBloc(apiRepository: ForgotPasswordRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => AddBidBloc(apiRepository: BidRepo()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              VerificationBloc(apiRepository: VerificationResponseRepository()),
          // child: Container(),
        ),
        BlocProvider(create: (context) => DropDownCubit()),
        BlocProvider(
          create: (context) => StoreImageCubit(),
        ),
        BlocProvider(
          create: (context) => CertificateStoreImageCubit(),
        ),
        BlocProvider(create: (context) => FetchHomeBloc()),
        BlocProvider(
            create: (context) => FetchProfileBloc(
                // fetchProfileRepository: FetchProfileRepository(),
                )),
        BlocProvider(
          create: (context) => FetchProviderBloc(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => DateCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => TimeCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => TimeValidationBloc(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => ExpectedHoursCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => ViewRequestPageCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              FetchNotificationBloc(apiRepository: NotificationRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              FetchBookingBloc(apiRepository: BookingRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => BookingBloc(apiRepository: BookingRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => ChatUserListBloc(repo: ChatUserListRepo()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => ChoosePlaceCubit(),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              CancelBookingBloc(apiRepository: BookingRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              BookPaymentBloc(apiRepository: PaymentRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) =>
              FetchPaymentBloc(apiRepository: PaymentRepository()),
          // child: Container(),
        ),
        BlocProvider(
          create: (context) => FetchBidListBloc(apiRepository: BidRepo()),
        ),
        BlocProvider(create: (context) => ConnectivityBloc()),
        BlocProvider(create: (context) => NavigationCubit()),
        BlocProvider(create: (context) => LocationFocusCubit()),
        BlocProvider(
            create: (context) =>
                AcceptBookingBloc(apiRepository: BookingRepository())),
        BlocProvider(
            create: (context) => IndividualChatBloc(repo: ChatUserListRepo())),
        BlocProvider(
            create: (context) => AddBidCommentBloc(apiRepository: BidRepo())),
        BlocProvider(
            create: (context) => FetchCommentBloc(apiRepository: BidRepo())),
        BlocProvider(
            create: (context) =>
                LogoutBloc(apiRepository: LogoutRespository())),
        BlocProvider(
            create: (context) =>
                RescheduleBloc(apiRepository: BookingRepository())),
        BlocProvider(
            create: (context) =>
                MakeCompleteBloc(apiRepository: BookingRepository())),
        BlocProvider(
            create: (context) =>
                AddReviewBloc(apiRepository: ReviewRateRepository())),
        BlocProvider(
            create: (context) =>
                FavoriteProviderBloc(apiRepository: FavoriteProviderRepo())),
        BlocProvider(
            create: (context) =>
                FetchFavProviderBloc(apiRepository: FavoriteProviderRepo())),
        BlocProvider(
            create: (context) => ChartBloc(apiRepository: ProviderHomeRepo())),
        BlocProvider(create: (context) => FetchRequestCountBloc()),
      ],
      child: RepositoryProvider(
          create: (context) => LoginRepository(),
          child: KhaltiScope(
            publicKey: 'test_public_key_03c11c5f6c25454faadfce547ddf7ab1',
            builder: (context, navigatorKey) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ne', 'NP'),
                ],
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primary_color_dark(),
                      foregroundColor: Colors.red,
                      minimumSize: const Size(64, 50),
                    ),
                  ),
                  appBarTheme: AppBarTheme(
                      backgroundColor: ColorConstant.prmary_color_notdart()),
                  scaffoldBackgroundColor: ColorConstant.prmary_color_notdart(),
                  fontFamily: 'Poppins',
                ),
                onGenerateRoute: GeneratedRoute().onGeneratedRoute,
              );
            },
          )),
    );
  }
}
