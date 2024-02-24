import 'package:flutter/material.dart';
import 'package:gymfit_trainer/helpers/constants.dart';
import 'package:gymfit_trainer/helpers/custom_bottom_bar.dart';
import 'package:gymfit_trainer/helpers/theme_helper.dart';
import 'package:gymfit_trainer/models/seaarchObjects/notification_search_object.dart';
import 'package:gymfit_trainer/providers/login_provider.dart';
import 'package:gymfit_trainer/providers/notification_provider.dart';
import 'package:gymfit_trainer/providers/notification_rabbit_provider.dart';
import 'package:gymfit_trainer/routes/app_routes.dart';
import 'package:gymfit_trainer/screens/home/home_screen.dart';
import 'package:gymfit_trainer/screens/login/login_screen.dart';
import 'package:gymfit_trainer/screens/notifications/add_notification_screen.dart';
import 'package:gymfit_trainer/screens/notifications/notification_screen.dart';
import 'package:gymfit_trainer/screens/reservation/reservaations_screen.dart';
import 'package:gymfit_trainer/screens/user/change_password_screen.dart';
import 'package:gymfit_trainer/screens/user/user_profile.dart';
import 'package:gymfit_trainer/utils/error_dialog.dart';

import 'package:provider/provider.dart';

class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({Key? key}) : super(key: key);

  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  late GlobalKey<NavigatorState> navigatorKey;
  late MediaQueryData mediaQueryData;
  late NotificationRabbitProvider _notificationRabbitProvider;
  late UserLoginProvider _loginProvider;
  int? _userId;
  int unreadNotifications = 0;
  bool notificationsLoaded = false;

  
  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey();
    _notificationRabbitProvider = context.read<NotificationRabbitProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    loadUser();

    loadNotifications();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    _userId = id;
  }

 void setAsSeen(int id) async {
    await _notificationRabbitProvider.setAsSeen(id);
  }




  void loadNotifications() async {
    try {
      NotificationsSearchObject searchObject =
          NotificationsSearchObject(userId: _userId, PageSize: 10000);

      var notificationsResponse =
          await _notificationRabbitProvider.getPaged(searchObject: searchObject);
      unreadNotifications = notificationsResponse
          .where((notification) => notification.isRead == false)
          .length;

      // Notify the FutureBuilder that notifications are loaded
      setState(() {
        notificationsLoaded = true;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
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

 AppBar _buildAppbar(BuildContext context) {
  return AppBar(
    backgroundColor: appTheme.bgSecondary,
    automaticallyImplyLeading: false, // Remove back button
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
        ),
        Image.asset(
          "assets/images/logo1.png",
          height: 50,
          width: 110,
          fit: BoxFit.contain,
        ),
      ],
    ),
    actions: [
      IconButton(
        icon: Stack(
          children: [
            Icon(
              Icons.notifications,
              color: appTheme.blue,
            ),
            if (unreadNotifications > 0)
              Positioned(
                top: -5,
                left: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    unreadNotifications.toString(),
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
        onPressed: () async {
          setState(() {
            unreadNotifications = 0;
          });

          setAsSeen(_userId!);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NotificationForm();
            },
          );
        },
      ),
      // Menu Icon
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          showMenu(
            context: context,
            color: teal,
            position: RelativeRect.fromRect(
              Rect.fromPoints(
                Offset(
                    MediaQuery.of(context).size.width - 50, kToolbarHeight),
                Offset(
                    MediaQuery.of(context).size.width, kToolbarHeight + 20),
              ),
              overlay.localToGlobal(Offset.zero) & overlay.size,
            ),
            items: [
             
              PopupMenuItem(
                child: ListTile(
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    _loginProvider.logout();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ],
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
      case BottomBarEnum.MyReservation:
        return AppRoutes.myReservationsScreen;
      case BottomBarEnum.AddNotification:
        return AppRoutes.addNotification;
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
      case AppRoutes.myReservationsScreen:
         return MyReservationsScreen();
      case AppRoutes.addNotification:
         return AddNotificationScreen();
      case AppRoutes.userProfileScreen:
         return UserProfileScreen();
         case AppRoutes.changePassword:
         return ChangePasswordScreen();
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
