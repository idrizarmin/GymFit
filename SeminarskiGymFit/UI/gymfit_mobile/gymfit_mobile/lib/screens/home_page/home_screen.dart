import 'package:gymfit_mobile/screens/home_page/widgets/home_item_widget.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';
import 'package:gymfit_mobile/widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String radioGroup = "";
  late MediaQueryData mediaQueryData;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Početna",
                    style: CustomTextStyles.titleMediumMedium,
                  ),
                ),
                SizedBox(height: 11),
                _buildGymBasics(context),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 19),
                  child: Text(
                    "Galerija",
                    style: CustomTextStyles.titleMedium_1,
                  ),
                ),
                SizedBox(height: 3),
                _buildTwentySix(context),
                SizedBox(height: 59),
                _buildStandard(context),
                _buildGodiNje(context),
              ],
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
  Widget _buildGymBasics(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: EdgeInsets.only(
        left: 19,
        right: 30,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 11,
      ),
      decoration: AppDecoration.fillOnErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BUILD YOUR PERFECT BODY!",
            style: CustomTextStyles.titleLargeOnPrimaryContainerMedium,
          ),
          SizedBox(height: 7),
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.gym1,
                              height: double.infinity,
                              width: double.infinity,
                              radius: BorderRadius.circular(10),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 13,
                                  bottom: 14,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 41),
                                      child: Text(
                                        "01",
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                    ),
                                    Text(
                                      "GRUPNI TRENINZI",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.titleMedium_1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
                      SizedBox(
                        height: 140,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.gym2,
                              height: double.infinity,
                              width: double.infinity,
                              radius: BorderRadius.circular(10),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 4,
                                  right: 2,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "03",
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                    Text(
                                      "BALANSIRANA DIJETA",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.titleMedium_1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.gym3,
                          height: double.infinity,
                          width: double.infinity,
                          radius: BorderRadius.circular(10),
                          alignment: Alignment.center,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 84,
                            width: 93,
                            margin: EdgeInsets.only(bottom: 78),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      "INDIVIDUALNI TRENINZI",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: CustomTextStyles.titleMedium_1,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "02",
                                    style: theme.textTheme.headlineLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  /// Section Widget
  Widget _buildTwentySix(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 18,
        right: 30,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: AppDecoration.fillOnErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 11),
          Padding(
            padding: EdgeInsets.only(left: 7),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 106,
                crossAxisCount: 3,
                mainAxisSpacing: 17,
                crossAxisSpacing: 17,
              ),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return HomeItemWidget();
              },
            ),
          ),
          SizedBox(height: 2),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Prikaži sve",
                    style: CustomTextStyles.bodyMediumErrorContainer,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgVector9,
                    height: 10,
                    width: 12,
                    margin: EdgeInsets.only(
                      left: 4,
                      top: 4,
                      bottom: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStandard(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 387,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUser,
            height: 30,
            width: 30,
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(right: 97),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 21),
                    child: Text(
                      "70 KM",
                      style: CustomTextStyles.titleMediumMedium18,
                    ),
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgCalendar,
                    height: 32,
                    width: 32,
                    margin: EdgeInsets.only(
                      left: 1,
                      top: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgHome,
            height: 32,
            width: 32,
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(
              left: 15,
              bottom: 2,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgRectangle4164,
            height: 8,
            width: 387,
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 2),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCalendarGray100,
            height: 30,
            width: 30,
            alignment: Alignment.bottomCenter,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 23,
                bottom: 4,
              ),
              child: CustomRadioButton(
                width: 317,
                text: "Standard",
                value: "Standard",
                groupValue: radioGroup,
                isRightCheck: true,
                onChange: (value) {
                  radioGroup = value;
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: 2,
                right: 81,
              ),
              child: Text(
                "60 KM",
                style: CustomTextStyles.titleMediumMedium18,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 74,
                bottom: 9,
              ),
              child: Text(
                "Penzioneri",
                style: CustomTextStyles.bodyMediumErrorContainer,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 152,
                top: 2,
              ),
              child: Text(
                "50 KM",
                style: CustomTextStyles.titleMediumMedium18,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 149,
                bottom: 7,
              ),
              child: Text(
                "Studenti",
                style: CustomTextStyles.bodyMediumErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGodiNje(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 31,
          right: 34,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Godišnje",
                    style: CustomTextStyles.bodyMediumInter,
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 40,
                      width: 99,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "770 KM",
                              style: CustomTextStyles.titleMediumMedium18,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Standard",
                              style: CustomTextStyles.bodyMediumErrorContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 57,
              width: 207,
              margin: EdgeInsets.only(
                left: 3,
                top: 16,
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 57,
                      width: 118,
                      margin: EdgeInsets.only(right: 7),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "660 KM",
                        style: CustomTextStyles.titleMediumMedium18,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                        bottom: 9,
                      ),
                      child: Text(
                        "Penzioneri",
                        style: CustomTextStyles.bodyMediumErrorContainer,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 3,
                        top: 10,
                      ),
                      child: Text(
                        "550 KM",
                        style: CustomTextStyles.titleMediumMedium18,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 7),
                      child: Text(
                        "Studenti",
                        style: CustomTextStyles.bodyMediumErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
