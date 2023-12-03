import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/custom_button_style.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/widgets/custom_elevated_button.dart';
import 'package:gymfit_mobile/widgets/custom_floating_field.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
 late TextEditingController idrizNinetyNineController = TextEditingController();
 late TextEditingController arminIdrizController = TextEditingController();
 late TextEditingController emailController = TextEditingController();
 late TextEditingController telefonController = TextEditingController();
 late TextEditingController muKiController = TextEditingController();
late  TextEditingController datumroenjaController = TextEditingController();
late  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
 late GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 776,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 60,
                      ),
                      decoration: AppDecoration.outlineBlack90001,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 3,
                              right: 30,
                            ),
                            child: Row(
                              children: [
                                CustomImageView(
                                  imagePath:
                                      ImageConstant.imgBillGatesProfilePic1,
                                  height: 127,
                                  width: 90,
                                  radius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 23,
                                    top: 32,
                                    bottom: 3,
                                  ),
                                  child: Column(
                                    children: [
                                      
                                      SizedBox(
                                        width: 191,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Godina",
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 26),
                                              child: Text(
                                                "Visina",
                                                style:
                                                    theme.textTheme.bodyMedium,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Kilaža",
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        width: 171,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 9),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 26,
                                              width: 20,
                                              margin:
                                                  EdgeInsets.only(bottom: 1),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "23",
                                                      style: theme
                                                          .textTheme.titleLarge,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "23",
                                                      style: theme
                                                          .textTheme.titleLarge,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "190",
                                              style: theme.textTheme.titleLarge,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 1),
                                              child: Text(
                                                "90",
                                                style:
                                                    theme.textTheme.titleLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      _buildUrediProfil(context),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 35),
                          _buildIdrizNinetyNine(context),
                          SizedBox(height: 12),
                          _buildArminIdriz(context),
                          SizedBox(height: 13),
                          _buildEmail(context),
                          SizedBox(height: 16),
                          _buildTelefon(context),
                          SizedBox(height: 16),
                          _buildMuKi(context),
                          SizedBox(height: 16),
                          _buildDatumroenja(context),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 50,
                              width: 184,
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  _buildOdjava(context),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgSignOutSqure,
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 48),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 23),
                        ],
                      ),
                    ),
                  ),
                  _buildFiftyOne(context),
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle41641,
                    height: 8,
                    width: 387,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 49),
                  ),
                ],
              ),
            ),
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


  /// Section Widget
  Widget _buildUrediProfil(BuildContext context) {
    return CustomElevatedButton(
      height: 27,
      width: 173,
      text: "Uredi profil",
      buttonStyle: CustomButtonStyles.fillBlueCcTL10,
      buttonTextStyle: theme.textTheme.bodyLarge!,
      alignment: Alignment.centerLeft,
    );
  }

  /// Section Widget
  Widget _buildIdrizNinetyNine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 19),
      child: CustomFloatingTextField(
        controller: idrizNinetyNineController,
        labelText: "Korisnicko ime: ",
        labelStyle: CustomTextStyles.titleMediumMedium,
        hintText: "Korisnicko ime: ",
      ),
    );
  }

  /// Section Widget
  Widget _buildArminIdriz(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 19),
      child: CustomFloatingTextField(
        controller: arminIdrizController,
        labelText: "Ime i prezime:",
        labelStyle: CustomTextStyles.titleMediumMedium,
        hintText: "Ime i prezime:",
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 19),
      child: CustomFloatingTextField(
        controller: emailController,
        labelText: " Email:",
        labelStyle: CustomTextStyles.titleMediumMedium,
        hintText: " Email:",
        textInputType: TextInputType.emailAddress,
      ),
    );
  }

  /// Section Widget
  Widget _buildTelefon(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 19),
      child: CustomFloatingTextField(
        controller: telefonController,
        labelText: "Telefon: ",
        labelStyle: CustomTextStyles.titleMediumMedium,
        hintText: "Telefon: ",
      ),
    );
  }

  /// Section Widget
  Widget _buildMuKi(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 19),
      child: CustomFloatingTextField(
        controller: muKiController,
        labelText: "Spol:",
        labelStyle: CustomTextStyles.titleMediumMedium,
        hintText: "Spol:",
      ),
    );
  }

  /// Section Widget
  Widget _buildDatumroenja(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 19),
      child: CustomFloatingTextField(
        controller: datumroenjaController,
        labelText: "Datum rođenja:",
        labelStyle: CustomTextStyles.titleMediumMedium,
        hintText: "Datum rođenja:",
        textInputAction: TextInputAction.done,
      ),
    );
  }

  /// Section Widget
  Widget _buildOdjava(BuildContext context) {
    return CustomElevatedButton(
      height: 28,
      width: 184,
      text: "Odjava",
      buttonTextStyle: CustomTextStyles.titleLargeRegular_1,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Section Widget
  Widget _buildFiftyOne(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: AppDecoration.fillBlack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 3),
            Text(
              "Idriz99",
              style: CustomTextStyles.titleLargeInterOnPrimaryContainer,
            ),
            Divider(
              color: appTheme.blueGray100,
            ),
          ],
        ),
      ),
    );
  }

  
}
