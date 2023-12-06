import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/custom_button_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/widgets/custom_elevated_button.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            image: DecorationImage(
              image: AssetImage(ImageConstant.imgStart),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 52, vertical: 106),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.logo,
                  height: 120,
                  width: 240,
                ),
                Spacer(),
                CustomElevatedButton(
                  text: "Prijava",
                  buttonStyle: CustomButtonStyles.fillBlueCc,
                  onPressed: () {
                    navigateToLogin(context);
                  },
                ),
                SizedBox(height: 19),
                CustomElevatedButton(
                  text: "Registracija",
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  onPressed: () {
                    navigateToRegistration(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the loginScreen when the action is triggered.
  navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  navigateToRegistration(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registrationScreen);
  }
}
