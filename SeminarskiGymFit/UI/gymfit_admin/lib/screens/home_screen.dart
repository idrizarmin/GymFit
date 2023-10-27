import 'package:flutter/material.dart';
import 'package:gymfit_admin/screens/components/base_screen.dart';
import 'package:gymfit_admin/screens/components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _currentPage = BaseScreen();

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
            Expanded(
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
