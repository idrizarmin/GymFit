import 'package:flutter/material.dart';
import 'package:gymfit_admin/screens/components/side_menu.dart';
import 'package:gymfit_admin/screens/dashboard/dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _currentPage = const DashboardScreen();

  void _changePage(Widget page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 180,
              child: SideMenu(onMenuItemClicked: _changePage),
            ),
            Expanded(
              flex: 5,
              child: _currentPage,
            ),
          ],
        ),
      ),
    );
  }
}
