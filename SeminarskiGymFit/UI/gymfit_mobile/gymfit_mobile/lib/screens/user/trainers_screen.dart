import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/user.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';

import 'package:flutter/material.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({Key? key}) : super(key: key);

  @override
  _TrainersScreenState createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late MediaQueryData mediaQueryData;
 List<User> trainers = <User>[];
  late UserProvider _userProvider;

  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    loadTrainers();
  }
 void loadTrainers() async {
    try {
      var usersResponse =
          await _userProvider.getTrainers();
      setState(() {
        trainers = usersResponse;
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
                  "Treneri",
                  style: CustomTextStyles.titleMediumMedium,
                ),
              ),
              SizedBox(height: 14),
              Expanded(

                child: _buildTrainers(context)
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


  Widget _buildTrainers(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: AppDecoration.fillBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: trainers.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white, // Set the border color
                  width: 1.0, // Set the border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainers[index].firstName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(trainers[index].lastName),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
