import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/package.dart';
import 'package:gymfit_mobile/models/searchObjects/package_search_ocbject.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/package_provider.dart';
import 'package:gymfit_mobile/providers/user_package_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MembershipPaymentForm extends StatefulWidget {
  @override
  _MembershipPaymentFormState createState() => _MembershipPaymentFormState();
}

class _MembershipPaymentFormState extends State<MembershipPaymentForm> {
  List<Package> packages = <Package>[];
  late UserPackageProvider _userPackageProvider;
  late PackageProvider _packageProvider;
  late UserLoginProvider _loginProvider;
  Package? _selectedPackage;
  int? _selectedMonths;
  int currentPage = 1;
  int pageSize = 100;
  int? _userId;
  Map<String, dynamic>? paymentIntent;

  @override
  void initState() {
    super.initState();
    _packageProvider = context.read<PackageProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    _userPackageProvider = context.read<UserPackageProvider>();
    loadPackages();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    _userId = id;
  }

  void loadPackages() async {
    try {
      var response = await _packageProvider.getPaged(
          searchObject:
              PackageSearchObject(PageNumber: currentPage, PageSize: pageSize));

      setState(() {
        packages = response;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  double calculateTotalPrice() {
    if (_selectedPackage != null && _selectedMonths != null) {
      double basePrice = _selectedPackage!.price! * _selectedMonths!;

      // Popustna osnovu broja mjeseci
      if (_selectedMonths! >= 6 && _selectedMonths! < 12) {
        // Popust od 5% za više od 6 i manje od 12 mjeseci
        return basePrice * 0.95;
      } else if (_selectedMonths! == 12) {
        // Popust od 10% za 12 mjeseci
        return basePrice * 0.9;
      }

      // Nema popusta za manje od 6 mjeseci
      return basePrice;
    }
    return 0;
  }

  showPaymentSheet() async {
    if (_selectedPackage == null || _selectedMonths == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor:  appTheme.bgSecondary,
          content: Text("Molimo odaberite paket i broj mjeseci."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
              ),
              child: Text(
                "OK",
                style: TextStyle(color: white),
              ),
            ),
          ],
        ),
      );
      return;
    }

    var paymentIntentData = await createPaymentIntent(
        (calculateTotalPrice() * 100).round().toString(), 'BAM');
    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            merchantDisplayName: 'GymFit',
            appearance: const PaymentSheetAppearance(
              primaryButton: PaymentSheetPrimaryButtonAppearance(
                  colors: PaymentSheetPrimaryButtonTheme(
                      light: PaymentSheetPrimaryButtonThemeColors(
                          background: Colors.teal))),
            ),
          ),
        )
        .then((value) {})
        .onError((error, stackTrace) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Poništena transakcija"),
              ));
    });

    try {
        await Stripe.instance.presentPaymentSheet();

      InsertUserPackage();
    } catch (e) {
      //silent
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  DateTime calculateExpirationDate(int months) {
    DateTime currentDate = DateTime.now();

    DateTime expirationDate = currentDate.add(Duration(days: 30 * months));

    return expirationDate;
  }

  void InsertUserPackage() async {
    try {
      loadUser();
      DateTime expirationDate = calculateExpirationDate(_selectedMonths!);

      var newPackage = {
        "id": 0,
        "pauseDuration": 0,
        "isPaused": false,
        "expired": false,
        "activationDate": DateTime.now().toUtc().toIso8601String(),
        "expirationDate": expirationDate.toUtc().toIso8601String(),
        "pausedOnDate": DateTime.now().toUtc().toIso8601String(),
        "activateOnDate": DateTime.now().toUtc().toIso8601String(),
        "userId": _userId,
        "packageId": _selectedPackage!.id
      };

      var userPackage = await _userPackageProvider.insert(newPackage);

      if (userPackage == "OK") {
        currentPage == 1;
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Color(0XFF12B422),
              content: Text('Uspjesna uplata paketa.',
                  style: TextStyle(
                    color: Colors.white,
                  ))),
        );
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: appTheme.bgSecondary.withOpacity(0.97),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildTitle(),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: DropdownButton<Package>(
                        dropdownColor: teal,
                        value: _selectedPackage,
                        items: packages.map((Package package) {
                          return DropdownMenuItem<Package>(
                            value: package,
                            child: Text(package.name ?? ''),
                          );
                        }).toList(),
                        onChanged: (Package? selectedPackage) {
                          setState(() {
                            _selectedPackage = selectedPackage;
                          });
                        },
                        hint: Text('Izaberite paket', style: TextStyle(color: white),),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: DropdownButton<int>(
                        dropdownColor: teal,
                        value: _selectedMonths,
                        items: List.generate(12, (index) {
                          return DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text('${index + 1} months'),
                          );
                        }),
                        onChanged: (int? selectedMonths) {
                          setState(() {
                            _selectedMonths = selectedMonths;
                          });
                        },
                        hint: Text('Izaberite broj mjeseci',style: TextStyle(color: white)),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Ukupno',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'bs')
                          .format(calculateTotalPrice()),
                      style: const TextStyle(
                          color: Color(0XFF12B422),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: teal,
                        ),
                        child: Text(
                          "Zatvori",
                          style: TextStyle(color: white),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showPaymentSheet();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: teal,
                        ),
                        child: Text(
                          "Uplati",
                          style: TextStyle(color: white),
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
    );
  }

  Widget _buildTitle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Uplata članarine",
          style: TextStyle(
            color: white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
