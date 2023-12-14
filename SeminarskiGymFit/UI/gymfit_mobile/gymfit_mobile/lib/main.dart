import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/http_overrides.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/notification_provider.dart';
import 'package:gymfit_mobile/providers/package_provider.dart';
import 'package:gymfit_mobile/providers/post_provider.dart';
import 'package:gymfit_mobile/providers/reservation_provider.dart';
import 'package:gymfit_mobile/providers/user_package_provider.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey = stripePublishKey;

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => UserProvider()),
         ChangeNotifierProvider(create: (_) => UserLoginProvider()),
         ChangeNotifierProvider(create: (_) => PostProvider()),
         ChangeNotifierProvider(create: (_) => ReservationProvider()),
         ChangeNotifierProvider(create: (_) => NotificationProvider()),
         ChangeNotifierProvider(create: (_) => PackageProvider()),
         ChangeNotifierProvider(create: (_) => UserPackageProvider()),
      ],
      child: MaterialApp(
        theme: theme,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        title: 'gymfit',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.startScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
