import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/reservation_provider.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late MediaQueryData mediaQueryData;
  late ReservationProvider _reservationProvider;
  late UserLoginProvider _loginProvider;
  int _status = 1;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    loadUser();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    _userId = id;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.bgSecondary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 1,
                ),
                decoration: AppDecoration.fillBlack,
                child: Text(
                  "Naziv stranice",
                  style: TextStyle(fontSize: 14, color: white),
                ),
              ),
              Container(
                height: 1.0,
                color: const Color.fromARGB(255, 214, 214, 214),
              ),

              // Expanded(
              //   child: SingleChildScrollView(
              //     child: Padding(
              //       padding: EdgeInsets.only(
              //         left: 5,
              //         right: 5,
              //       ),
              //       child: Column(
              //         children: [_buildReservationInfo(context)],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
