import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/custom_bottom_bar.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/searchObjects/notification_search_object.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/notification_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/screens/home_page/home_screen.dart';
import 'package:gymfit_mobile/screens/memberships/membership_screen.dart';
import 'package:gymfit_mobile/screens/notifications/notification_screen.dart';
import 'package:gymfit_mobile/screens/reservations/myReservations_screen.dart';
import 'package:gymfit_mobile/screens/reservations/reservations_screen.dart';
import 'package:gymfit_mobile/screens/start_screenn.dart';
import 'package:gymfit_mobile/screens/user/trainers_screen.dart';
import 'package:gymfit_mobile/screens/user/user_profile.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:provider/provider.dart';

class HomeContainerScreen extends StatefulWidget {
  const HomeContainerScreen({Key? key}) : super(key: key);

  @override
  _HomeContainerScreenState createState() => _HomeContainerScreenState();
}

class _HomeContainerScreenState extends State<HomeContainerScreen> {
  late GlobalKey<NavigatorState> navigatorKey;
  late MediaQueryData mediaQueryData;
  late NotificationProvider _notificationProvider;
  late UserLoginProvider _loginProvider;
  int? _userId;
  int unreadNotifications = 0;

  @override
  void initState() {
    super.initState();
    navigatorKey = GlobalKey();
    _notificationProvider = context.read<NotificationProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    loadUser();

    loadNotifications();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    _userId = id;
  }

  void setAsSeen() async {
    if (_userId != null) {
      _notificationProvider.setAsSeen(_userId!);
    }
  }

  Future<int> loadNotifications() async {
    try {
      NotificationsSearchObject searchObject =
          NotificationsSearchObject(userId: _userId, PageSize: 1000);

      var notificationsResponse =
          await _notificationProvider.getPaged(searchObject: searchObject);
      int unreadNotifications = notificationsResponse
          .where((notification) => notification.Read == false)
          .length;
      print(unreadNotifications);
      return unreadNotifications;
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
      return 0;
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
          SizedBox( width: 100,),
          Image.asset(
            "assets/images/logo1.png",
            height: 50,
            width: 110,
            fit: BoxFit.contain,
          ),
        ],
      ),
      actions: [
        // Notifications Icon
        IconButton(
          icon: FutureBuilder<int>(
            future: loadNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                int unreadNotifications = snapshot.data ?? 0;
                return Stack(
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
                );
              } else {
                return Container();
              }
            },
          ),
          onPressed: () {
            setAsSeen();
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
                  child: Container(
                    child: ListTile(
                      title: Text('Članarine'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
            navigatorKey.currentContext!, AppRoutes.membershipScreen);
                      },
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pop(context); 
                      _loginProvider.logout();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StartScreen()));
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
      case AppRoutes.membershipScreen:
        return MembershipScreen();
       
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
