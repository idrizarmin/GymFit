import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/widgets/custom_elevated_button.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';
import 'package:gymfit_mobile/widgets/custom_text_fptm_field.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  TextEditingController vectorFifteenController = TextEditingController();
  TextEditingController editTextController = TextEditingController();
  TextEditingController editTextController1 = TextEditingController();
  TextEditingController vectorSeventeenController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  late MediaQueryData mediaQueryData; 

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.bgSecondary,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 3),
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
                      "Rezervacije",
                      style: CustomTextStyles.titleMediumMedium,
                    ),
                  ),
                  SizedBox(height: 25),
                  _buildCalendar(context),
                  SizedBox(height: 36),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: Text(
                        "Trener:",
                        style: CustomTextStyles.bodyLargeInterGray200,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  _buildVectorFifteen(context),
                  SizedBox(height: 11),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 1),
                            child: Text(
                              "Vrijeme od:",
                              style: CustomTextStyles.bodyLargeInterGray200,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 87),
                            child: Text(
                              "Vrijeme do:",
                              style: CustomTextStyles.bodyLargeInterGray200,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildEditText2(context),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 31),
                      child: Text(
                        "Vrsta treninga:",
                        style: CustomTextStyles.bodyLargeInterGray200,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  _buildVectorSeventeen(context),
                  SizedBox(height: 10),
                  _buildRezervii(context),

                  // Divider(
                  //   indent: 22,
                  //   endIndent: 9,
                  // ),
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
  Widget _buildCalendar(BuildContext context) {
    return SizedBox(
      height: 214,
      width: 333,
      child: TableCalendar(
        locale: 'en_US',
        firstDay: DateTime(DateTime.now().year - 5),
        lastDay: DateTime(DateTime.now().year + 5),
        calendarFormat: CalendarFormat.month,
        rangeSelectionMode: rangeSelectionMode,
        startingDayOfWeek: StartingDayOfWeek.sunday,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: true,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(),
        headerVisible: false,
        focusedDay: focusedDay,
        rangeStartDay: rangeStart,
        rangeEndDay: rangeEnd,
        onDaySelected: (selectedDay, focusedDay) {},
        onRangeSelected: (start, end, focusedDay) {},
        onPageChanged: (focusedDay) {},
      ),
    );
  }

  /// Section Widget
  Widget _buildVectorFifteen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 29,
        right: 25,
      ),
      child: CustomTextFormField(
        controller: vectorFifteenController,
        suffix: Container(
          padding: EdgeInsets.fromLTRB(30, 11, 7, 11),
          decoration: BoxDecoration(
            color: theme.colorScheme.onErrorContainer,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgVector15,
            height: 18,
            width: 18,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 40,
        ),
        borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainer,
        fillColor: theme.colorScheme.onErrorContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2),
      child: CustomTextFormField(
        width: 147,
        controller: editTextController,
        borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainerTL10,
        fillColor: theme.colorScheme.onErrorContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildEditText1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 28),
      child: CustomTextFormField(
        width: 153,
        controller: editTextController1,
        borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainerTL10,
        fillColor: theme.colorScheme.onErrorContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildEditText2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 27,
        right: 32,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEditText(context),
          _buildEditText1(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildVectorSeventeen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28,
        right: 26,
      ),
      child: CustomTextFormField(
        controller: vectorSeventeenController,
        textInputAction: TextInputAction.done,
        suffix: Container(
          padding: EdgeInsets.fromLTRB(30, 11, 7, 11),
          decoration: BoxDecoration(
            color: theme.colorScheme.onErrorContainer,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: CustomImageView(
            imagePath: ImageConstant.imgVector15,
            height: 18,
            width: 18,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 40,
        ),
        borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainer,
        fillColor: theme.colorScheme.onErrorContainer,
      ),
    );
  }

  /// Section Widget
  Widget _buildRezervii(BuildContext context) {
    return CustomElevatedButton(
      text: "Rezerviši",
      margin: EdgeInsets.only(
        left: 50,
        right: 50,
      ),
    );
  }
}
