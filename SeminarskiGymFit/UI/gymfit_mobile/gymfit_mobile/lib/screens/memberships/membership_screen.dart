import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/searchObjects/userPackage_search_object.dart';
import 'package:gymfit_mobile/models/user_package.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/user_package_provider.dart';
import 'package:gymfit_mobile/screens/memberships/membership_payment_screen.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MembershipScreen extends StatefulWidget {
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  late MediaQueryData mediaQueryData;

  late UserPackageProvider _userPackageProvider;
  late UserLoginProvider _loginProvider;
  int currentPage = 1;
  int pageSize = 1000000;
  int? _userId;
  bool? _expired = false;
  int _status = 1;
  List<UserPackage> _userPackages = <UserPackage>[];

  @override
  void initState() {
    super.initState();
    _userPackageProvider = context.read<UserPackageProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    loadUser();
    loadUserPackages();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    _userId = id;
  }

  void loadUserPackages() async {
    try {
      loadUser();
      UserPackageSearchObject searchObject = UserPackageSearchObject(
          expired: _expired,
          PageNumber: currentPage,
          PageSize: pageSize,
          userId: _userId);
      var Response =
          await _userPackageProvider.getPaged(searchObject: searchObject);
      if (mounted) {
        setState(() {
          _userPackages = Response;
        });
      }
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
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 1,
              ),
              color: Colors.black,
              child: Text(
                "Članarine",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              height: 1.0,
              color: const Color.fromARGB(255, 214, 214, 214),
            ),
            Row(
              children: [
                _buildStatusButton(1, "Aktivna"),
                _buildStatusButton(2, "Istekle"),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: Column(
                  children: [_buildUserPackageInfo(context)],
                ),
              ),
            ),
            Spacer(),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: teal),
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MembershipPaymentForm();
                    },
                  );
                },
                child: Text(
                  'Uplati članarinu',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserPackageInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: AppDecoration.fillBlack.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _userPackages.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_userPackages[index].package != null) ...[
                        Text(
                          'Trener: ${_userPackages[index].package!.name} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                      ],
                      _buildUserPaackageData('Datum aktivacije:',
                          '${_formatDate(_userPackages[index].activationDate)}'),
                      _buildUserPaackageData('Datum isteka:',
                          '${_formatDate(_userPackages[index].expirationDate)}'),
                      Divider()
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserPaackageData(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 2),
      ],
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }
    return DateFormat('dd.MM.yyyy').format(date);
  }

  Expanded _buildStatusButton(int status, String label) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _status == status ? Colors.teal : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.all(2),
          minimumSize: Size(2, 40),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          setState(() {
            _status = status;
            _expired = status == 2;
            loadUserPackages();
          });
        },
        child: Text(
          label,
          style: TextStyle(color: white, fontSize: 12),
        ),
      ),
    );
  }
}
