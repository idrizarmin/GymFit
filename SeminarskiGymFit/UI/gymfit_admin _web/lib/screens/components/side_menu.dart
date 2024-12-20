import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/providers/login_provider.dart';
import 'package:gymfit_admin/screens/dashboard/dashboard_screen.dart';
import 'package:gymfit_admin/screens/gyms/gym_screen.dart';
import 'package:gymfit_admin/screens/login_screen.dart';
import 'package:gymfit_admin/screens/notificatios/notifications_screen.dart';
import 'package:gymfit_admin/screens/packages/packages_screen.dart';
import 'package:gymfit_admin/screens/reports/report_screen.dart';
import 'package:gymfit_admin/screens/reservations/reservations_screen.dart';
import 'package:gymfit_admin/screens/users/admin_screen.dart';
import 'package:gymfit_admin/screens/users/test.dart';
import 'package:gymfit_admin/screens/users/trainer_screen.dart';
import 'package:gymfit_admin/screens/users/user_profile_screen.dart';
import 'package:gymfit_admin/screens/users/users_screen.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
    required this.onMenuItemClicked,
  }) : super(key: key);

  final Function(Widget) onMenuItemClicked;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isExpanded = false;
  late LoginProvider _loginProvider;


  @override
  void initState() {
    super.initState();
    _loginProvider = context.read<LoginProvider>();

  }

  @override
  Widget build(BuildContext context) {
   
    return Drawer(
      backgroundColor: secondaryColor,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/logo1.png'),
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0), 
                ),
                DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/dash.svg",
                  press: () {
                    widget.onMenuItemClicked(const DashboardScreen());
                  },
                ),
                DrawerListTile(
                  title: "Klijenti",
                  svgSrc: "assets/icons/users.svg",
                  press: () {
                    widget.onMenuItemClicked(const UsersScreen());
                  },
                ),
                DrawerListTile(
                  title: "Termini",
                  svgSrc: "assets/icons/reservation.svg",
                  press: () {
                    widget.onMenuItemClicked(const ReservationScreen());
                  },
                ),
                DrawerListTile(
                  title: "Obavijesti",
                  svgSrc: "assets/icons/notification.svg",
                  press: () {
                    widget.onMenuItemClicked(const NotificationsScreen());
                  },
                ),
                DrawerListTile(
                  title: "Treneri",
                  svgSrc: "assets/icons/trainer.svg",
                  press: () {
                    widget.onMenuItemClicked(const TrainerScreen());
                  },
                ),
                DrawerListTile(
                  title: "Teretana",
                  svgSrc: "assets/icons/gym.svg",
                  press: () {
                    widget.onMenuItemClicked(const GymScreen());
                  },
                ),
                DrawerListTile(
                  title: "Izvještaji",
                  svgSrc: "assets/icons/report.svg",
                  press: () {
                    widget.onMenuItemClicked(const ReportScreen());
                  },
                ),
                DrawerListTile(
                  title: "Paketi",
                  svgSrc: "assets/icons/package.svg",
                  press: () {
                    widget.onMenuItemClicked(const PackagesScreen());
                  },
                ),
                 ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                isExpanded =
                    value; 
              });
            },
            title: const Text(
              "Osnovni podaci",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              !isExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right, 
              color: Colors.white, 
            ),
            children: <Widget>[
              DrawerListTile(
                title: "Administratori",
                svgSrc: "assets/icons/admin.svg",
                press: () {
                  widget.onMenuItemClicked(const AdminScreen());
                },
              ),
               DrawerListTile(
                title: "Korisnički račun",
                svgSrc: "assets/icons/userProfile.svg",
                press: () {
                  widget.onMenuItemClicked(const UserProfileScreen());
                },
              ),
              // DrawerListTile(
              //   title: "Države",
              //   svgSrc: "assets/icons/country.svg",
              //   press: () {
              //     widget.onMenuItemClicked(const CountryScreen());
              //   },
              // ),
              // DrawerListTile(
              //   title: "Gradovi",
              //   svgSrc: "assets/icons/city.svg",
              //   press: () {
              //     widget.onMenuItemClicked(const CityScreen());
              //   },
              // ),
             
               
            ],
            
          ),
        
              ],
              
            ),

          ),
      DrawerListTile(
                  title: "Odjava",
                  svgSrc: "assets/icons/logout.svg",
                  press: () {
                      _loginProvider.logout();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen()));
                  },
                ),      
        ],
        
      ),
      
    );
    
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        height: 16,
        color: white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
