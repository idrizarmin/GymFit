import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/providers/city_provider.dart';
import 'package:gymfit_admin/providers/country_provider.dart';
import 'package:gymfit_admin/providers/login_provider.dart';
import 'package:gymfit_admin/providers/notification_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/home_screen.dart';
import 'package:gymfit_admin/screens/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CountryProvider()),
      ChangeNotifierProvider(create: (_) => CityProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      
    ],
    child: const MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RS II Material app',
      theme: ThemeData.dark().copyWith(
        buttonTheme: (ButtonThemeData(
          buttonColor: myButtonColor,
        )),
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
      ),
      home: const Scaffold(
        body: LoginScreen(),
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
  



