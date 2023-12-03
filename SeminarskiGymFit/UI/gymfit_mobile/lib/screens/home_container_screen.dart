import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/custom_bottom_bar.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/screens/home_page/home_screen.dart';
import 'package:gymfit_mobile/screens/reservations/myReservations_screen.dart';
import 'package:gymfit_mobile/screens/reservations/reservations_screen.dart';
import 'package:gymfit_mobile/screens/user/trainers_screen.dart';
import 'package:gymfit_mobile/screens/user/user_profile.dart';

class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({Key? key}) : super(key: key);

  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  late GlobalKey<NavigatorState> navigatorKey;
  late MediaQueryData mediaQueryData;

  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homePage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar() {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Reservation:
        return AppRoutes.reservationsScreen;
      case BottomBarEnum.MyReservation:
        return AppRoutes.myReservationsScreen;
      case BottomBarEnum.Trainers:
        return AppRoutes.trainersScreen;
      case BottomBarEnum.UserProfile:
        return AppRoutes.userProfileScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.reservationsScreen:
        return ReservationsScreen();
      case AppRoutes.myReservationsScreen:
        return MyReservationsScreen();
      case AppRoutes.trainersScreen:
        return TrainersScreen();
         case AppRoutes.userProfileScreen:
        return UserProfileScreen();
      default:
        return DefaultWidget();
    }
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Default Widget"),
    );
  }
}
