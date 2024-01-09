import 'package:flutter/material.dart';
import 'package:gymfit_mobile/screens/home_container_screen.dart';
import 'package:gymfit_mobile/screens/login_screen.dart';
import 'package:gymfit_mobile/screens/memberships/membership_screen.dart';
import 'package:gymfit_mobile/screens/registration/registration_screen.dart';
import 'package:gymfit_mobile/screens/reservations/myReservations_screen.dart';
import 'package:gymfit_mobile/screens/reservations/reservations_screen.dart';

import 'package:gymfit_mobile/screens/start_screenn.dart';
import 'package:gymfit_mobile/screens/user/change_password_screen.dart';
import 'package:gymfit_mobile/screens/user/trainers_screen.dart';
import 'package:gymfit_mobile/screens/user/user_profile.dart';

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

  static const String membershipScreen = '/membership_screen';

  static const String changePassword = '/changePassword';


  static Map<String, WidgetBuilder> routes = {
    startScreen: (context) => StartScreen(),
    loginScreen: (context) => LoginScreen(),
    registrationScreen: (context) => RegistrationScreen(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    trainersScreen: (context) => TrainersScreen(),
    reservationsScreen: (context) => ReservationsScreen(),
    userProfileScreen: (context) => UserProfileScreen(),
    myReservationsScreen: (context) => MyReservationsScreen(),
    membershipScreen: (context) => MembershipScreen(),
    changePassword: (context) => ChangePasswordScreen(),
  };
}
