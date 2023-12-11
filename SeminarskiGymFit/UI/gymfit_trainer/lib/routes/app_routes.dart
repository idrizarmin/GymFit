import 'package:flutter/material.dart';
import 'package:gymfit_trainer/screens/home/home_container_screen.dart';
import 'package:gymfit_trainer/screens/login/login_screen.dart';
import 'package:gymfit_trainer/screens/notifications/add_notification_screen.dart';
import 'package:gymfit_trainer/screens/reservation/reservaations_screen.dart';
import 'package:gymfit_trainer/screens/user/user_profile.dart';


class AppRoutes {

  static const String loginScreen = '/login_screen';


  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String addNotification = '/addnotification_screen';


  static const String userProfileScreen = '/user_profile_screen';

  static const String myReservationsScreen = '/my_reservations_screen';

  static const String notificationsScreen = '/notifications_screen';


  static Map<String, WidgetBuilder> routes = {
     loginScreen: (context) => LoginScreen(),
     homeContainerScreen: (context) => HomeContainerScreen(),
     userProfileScreen: (context) => UserProfileScreen(),
    myReservationsScreen: (context) => MyReservationsScreen(),
     addNotification: (context) => AddNotificationScreen(),
  };
}
