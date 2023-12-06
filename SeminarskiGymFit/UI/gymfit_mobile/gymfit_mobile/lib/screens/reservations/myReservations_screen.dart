import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:flutter/material.dart';

class MyReservationsScreen extends StatefulWidget {
  const MyReservationsScreen({Key? key}) : super(key: key);

  @override
  _MyReservationsScreenState createState() => _MyReservationsScreenState();
}

class _MyReservationsScreenState extends State<MyReservationsScreen> {
  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.bgSecondary,
        appBar: _buildAppbar(context),
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
                  "Moje rezervacije",
                  style: TextStyle(fontSize: 14, color: white),
                ),
              ),
              SizedBox(height: 14),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 17,
                      right: 5,
                    ),
                    child: Column(
                      children: [
                        
                      
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
          icon: Icon(
            Icons.notifications,
            color: appTheme.blue,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Form(
                    child: Text("Obavijesti"),
                  );
                });
          },
        ),
      ],
    );
  }

 
}
