import 'package:flutter/material.dart';
import 'package:gymfit_mobile/screens/home_container_screen.dart';
import 'package:gymfit_mobile/screens/login_screen.dart';
import 'package:gymfit_mobile/screens/registration/registration_screen.dart';

import 'package:gymfit_mobile/screens/start_screenn.dart';

class AppRoutes {
  static const String startScreen = '/start_screen';

  static const String loginScreen = '/login_screen';

  static const String registrationScreen = '/registration_screen';

  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String trainersScreen = '/trainers_screen';

  static const String reservationsScreen = '/reservations_screen';

  static const String userProfileScreen = '/user_profile_screen';

  static const String myReservationsScreen = '/my_reservations_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    startScreen: (context) => StartScreen(),
    loginScreen: (context) => LoginScreen(),
    registrationScreen: (context) => RegistrationScreen(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    // trainersScreen: (context) => TrainersScreen(),
    // reservationsScreen: (context) => ReservationsScreen(),
    // userProfileScreen: (context) => UserProfileScreen(),
    // myReservationsScreen: (context) => MyReservationsScreen(),
    // notificationsScreen: (context) => NotificationsScreen(),
    // appNavigationScreen: (context) => AppNavigationScreen()
  };
}
