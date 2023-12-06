import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/post_provider.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
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
