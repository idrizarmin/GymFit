import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymfit_trainer/providers/login_provider.dart';
import 'package:gymfit_trainer/providers/notification_provider.dart';
import 'package:gymfit_trainer/providers/photo_provider.dart';
import 'package:gymfit_trainer/providers/post_provider.dart';
import 'package:gymfit_trainer/providers/reservation_provider.dart';
import 'package:gymfit_trainer/providers/user_provider.dart';
import 'package:gymfit_trainer/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


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
          ChangeNotifierProvider(create: (_) => PhotoProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
        title: 'gymfit',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.loginScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}
