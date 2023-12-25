import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/gym.dart';
import 'package:gymfit_admin/models/package.dart';
import 'package:gymfit_admin/models/reservation.dart';
import 'package:gymfit_admin/models/searchObjects/package_search.dart';
import 'package:gymfit_admin/models/searchObjects/reservation_search.dart';
import 'package:gymfit_admin/models/searchObjects/user_package_search_object.dart';
import 'package:gymfit_admin/models/searchObjects/user_search.dart';
import 'package:gymfit_admin/models/user.dart';
import 'package:gymfit_admin/models/user_for_selection.dart';
import 'package:gymfit_admin/models/user_package.dart';
import 'package:gymfit_admin/providers/gym_provider.dart';
import 'package:gymfit_admin/providers/package_provider.dart';
import 'package:gymfit_admin/providers/reservation_provider.dart';
import 'package:gymfit_admin/providers/user_package_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late GymProvider _gymProvider;
  late ReservationProvider _reservationProvider;
  late UserProvider _userProvider;
  List<Reservation> reservations = <Reservation>[];

  Package? _selectedPackage;
  Package? _selectedPackage1;
  String _selectedIsActive = 'Svi';
  bool? isActive;
  List<Package> packages = <Package>[];
  late PackageProvider _packageProvider;
  late UserPackageProvider _userPackageProvider;
  List<UserPackage> _userPackages = <UserPackage>[];
  List<UserPackage> _userPackages1 = <UserPackage>[];
  List<UserPackage> _userPackagesFromTo = <UserPackage>[];
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  UserForSelection? selectedUser;
  UserForSelection? selectedUser1;
  UserForSelection? selectedUser2;
  UserForSelection? selectedTrainer;
  int? selectedGender;
  List<UserForSelection> users = <UserForSelection>[];
  List<User> users1 = <User>[];

  List<UserForSelection> trainers = <UserForSelection>[];

  Gym? gym;

  final List<String> reportData = ['Item 1', 'Item 2', 'Item 3'];

  @override
  void initState() {
    super.initState();
    _packageProvider = context.read<PackageProvider>();
    _gymProvider = GymProvider();
    _reservationProvider = ReservationProvider();
    _userProvider = UserProvider();
    _userPackageProvider = context.read<UserPackageProvider>();

    loadGym();
    loadUsers();
    loadTrainers();
    loadReservations();
    loadPackages();
    loadUserPackages();
    loadUsers1();
    loadUserPackages1();
  }

  void loadUsers1() async {
    UserSearchObject searchObject = UserSearchObject(
        PageNumber: 1,
        PageSize: 100000,
        isActive: isActive,
        spol: selectedGender);
    try {
      var usersResponse =
          await _userProvider.getPaged(searchObject: searchObject);
      setState(() {
        users1 = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadGym() async {
    try {
      var gymResponse = await _gymProvider.getById(2);
      if (mounted) {
        setState(() {
          gym = gymResponse;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadReservations() async {
    try {
      ReservationSearchObject searchObject = ReservationSearchObject(
          userId: selectedUser?.id,
          trainerId: selectedTrainer?.id,
          spol: selectedGender);
      var notificationsResponse =
          await _reservationProvider.getAll(searchObject: searchObject);
      if (mounted) {
        setState(() {
          reservations = notificationsResponse;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadUsers() async {
    try {
      var usersResponse = await _userProvider.getusersForSelection();
      if (mounted) {
        setState(() {
          users = usersResponse;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadTrainers() async {
    try {
      var usersResponse = await _userProvider.getTrainersForSelection();
      if (mounted) {
        setState(() {
          trainers = usersResponse;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadUserPackages() async {
    try {
      UserPackageSearchObject searchObject = UserPackageSearchObject(
        expired: null,
        PageNumber: 1,
        PageSize: 10000,
        userId: selectedUser1?.id,
        packageId: (_selectedPackage != null) ? _selectedPackage!.id : null,
      );
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

  void loadUserPackages1() async {
    try {
      UserPackageSearchObject searchObject = UserPackageSearchObject(
        expired: null,
        PageNumber: 1,
        PageSize: 10000,
        userId: selectedUser2?.id,
        packageId: (_selectedPackage1 != null) ? _selectedPackage1!.id : null,
      );
      var Response =
          await _userPackageProvider.getPaged(searchObject: searchObject);
      if (mounted) {
        setState(() {
          _userPackages1 = Response;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadUserPackagesFromTo() async {
    try {
      UserPackageSearchObject searchObject = UserPackageSearchObject(
        expired: null,
        PageNumber: 1,
        PageSize: 10000,
        fromDate: fromDate,
        toDate: toDate,
        userId: selectedUser2?.id,
        packageId: (_selectedPackage1 != null) ? _selectedPackage1!.id : null,
      );
      var Response =
          await _userPackageProvider.getPaged(searchObject: searchObject);
      if (mounted) {
        setState(() {
          _userPackagesFromTo = Response;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadPackages() async {
    try {
      var response = await _packageProvider.getPaged(
          searchObject: PackageSearchObject(PageNumber: 1, PageSize: 10000));

      setState(() {
        packages = response;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: defaultPadding / 2),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 18, 16, 50),
                      width: 2.0,
                    ),
                  ),
                ),
                child: const Header(pageTitle: "Izvještaji"),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          buildReservationsReport(),
                          SizedBox(
                            width: 20,
                          ),
                          buildUserPackagesReport(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          buildUsersReport(),
                          SizedBox(
                            width: 20,
                          ),
                          buildUsersPaymentReport(),
                          SizedBox(
                            width: 20,
                          ),
                          buildPaymentsReport(),
                        ],
                      )
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

  Expanded buildPaymentsReport() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Izvještaj o uplatama",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  Paket:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<Package>(
                    isExpanded: true,
                    value: _selectedPackage1,
                    items: [
                      // Dodajte "Sve" kao prvi element u listu
                      const DropdownMenuItem<Package>(
                        value: null,
                        child: Text('  Svi'),
                      ),
                      ...packages.map((Package package) {
                        return DropdownMenuItem<Package>(
                          value: package,
                          child: Text(package.name ?? ''),
                        );
                      }).toList(),
                    ],
                    onChanged: (Package? selectedPackage) {
                      setState(() {
                        _selectedPackage1 = selectedPackage;
                      });
                      loadUserPackagesFromTo();
                    },
                    hint: Text('Izaberite paket'),
                    underline: Container(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // dodati filtere za datum
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          controller: _fromDateController,
                          decoration: const InputDecoration(
                            labelText: '  Datum od:',
                            hintText: 'Odaberite datum',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: fromDate,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null && pickedDate != fromDate) {
                              setState(() {
                                fromDate = pickedDate;
                                _fromDateController.text =
                                    "  ${pickedDate.day}.${pickedDate.month}.${pickedDate.year}.";
                              });
                              loadUserPackagesFromTo();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextFormField(
                          controller: _toDateController,
                          decoration: const InputDecoration(
                            labelText: '  Datum do:',
                            hintText: 'Odaberite datum',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: toDate,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null && pickedDate != toDate) {
                              setState(() {
                                toDate = pickedDate;
                                _toDateController.text =
                                    "  ${pickedDate.day}.${pickedDate.month}.${pickedDate.year}.";
                              });
                              loadUserPackagesFromTo();
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: _displayPaymentsPdf,
                    child: Text(
                      'Prikaži PDF',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildUsersPaymentReport() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Izvještaj o uplatama klijenta",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  Klijent:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SearchChoices.single(
                    hint: Text("Odaberite klijenta"),
                    items: users
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Text('${user.firstName} ${user.lastName}'),
                            ))
                        .toList(),
                    value: selectedUser2,
                    isExpanded: true,
                    onChanged: (selectedItem) {
                      setState(() {
                        selectedUser2 = selectedItem as UserForSelection?;
                      });
                      loadUserPackages1();
                    },
                    closeButton: 'Zatvori',
                    searchHint: 'Pretraži korisnike',
                    underline: Container(),
                    padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                    displayClearIcon: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text('  Paket:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<Package>(
                    isExpanded: true,
                    value: _selectedPackage1,
                    items: [
                      // Dodajte "Sve" kao prvi element u listu
                      const DropdownMenuItem<Package>(
                        value: null,
                        child: Text('  Svi'),
                      ),
                      ...packages.map((Package package) {
                        return DropdownMenuItem<Package>(
                          value: package,
                          child: Text(package.name ?? ''),
                        );
                      }).toList(),
                    ],
                    onChanged: (Package? selectedPackage) {
                      setState(() {
                        _selectedPackage1 = selectedPackage;
                      });
                      loadUserPackages1();
                    },
                    hint: Text('Izaberite paket'),
                    underline: Container(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: _displayUserPaymentsPdf,
                    child: Text(
                      'Prikaži PDF',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildUsersReport() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Izvještaj o klijentima",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  Spol:'),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButton<int>(
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        value: selectedGender,
                        items: <int?>[null, 0, 1].map((int? value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(value == null
                                  ? 'Svi'
                                  : value == 0
                                      ? 'Muški'
                                      : 'Ženski'),
                            ),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedGender = newValue;
                            loadUsers1();
                          });
                        },
                        underline: Container(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                const Text('  Status:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text("Aktivni računi"),
                    value: _selectedIsActive,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    items:
                        <String>['Svi', 'Aktivni', 'Neaktivni'].map((String a) {
                      return DropdownMenuItem<String>(
                        value: a,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(a),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedIsActive = newValue ?? 'Svi';

                        // Ovdje postavljamo isActive prema odabiru
                        if (_selectedIsActive == 'Aktivni') {
                          isActive = true;
                        } else if (_selectedIsActive == 'Neaktivni') {
                          isActive = false;
                        } else {
                          isActive = null;
                        }

                        loadUsers1();
                      });
                    },
                    underline: const Text(""),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: _displayUserPdf,
                    child: Text(
                      'Prikaži PDF',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildUserPackagesReport() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Izvještaj o članarinama za klijenta",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  Klijent:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SearchChoices.single(
                    hint: Text("Odaberite klijenta"),
                    items: users
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Text('${user.firstName} ${user.lastName}'),
                            ))
                        .toList(),
                    value: selectedUser1,
                    isExpanded: true,
                    onChanged: (selectedItem) {
                      setState(() {
                        selectedUser1 = selectedItem as UserForSelection?;
                      });
                      loadUserPackages();
                    },
                    closeButton: 'Zatvori',
                    searchHint: 'Pretraži korisnike',
                    underline: Container(),
                    padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                    displayClearIcon: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text('  Paket:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButton<Package>(
                    isExpanded: true,
                    value: _selectedPackage,
                    items: [
                      // Dodajte "Sve" kao prvi element u listu
                      DropdownMenuItem<Package>(
                        value: null,
                        child: Text('  Svi'),
                      ),
                      ...packages.map((Package package) {
                        return DropdownMenuItem<Package>(
                          value: package,
                          child: Text(package.name ?? ''),
                        );
                      }).toList(),
                    ],
                    onChanged: (Package? selectedPackage) {
                      setState(() {
                        _selectedPackage = selectedPackage;
                      });
                      loadUserPackages();
                    },
                    hint: Text('Izaberite paket'),
                    underline: Container(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: _displayUserPackagesPdf,
                    child: Text(
                      'Prikaži PDF',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildReservationsReport() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Izvještaj o rezervacijama za klijenta",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  Klijent:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SearchChoices.single(
                    hint: Text("Odaberite klijenta"),
                    items: users
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Text('${user.firstName} ${user.lastName}'),
                            ))
                        .toList(),
                    value: selectedUser,
                    isExpanded: true,
                    onChanged: (selectedItem) {
                      setState(() {
                        selectedUser = selectedItem as UserForSelection?;
                      });
                      loadReservations();
                    },
                    closeButton: 'Zatvori',
                    searchHint: 'Pretraži korisnike',
                    underline: Container(),
                    padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                    displayClearIcon: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text('  Trener:'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SearchChoices.single(
                    hint: const Text("Odaberite trenera"),
                    isExpanded: true,
                    items: trainers
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Text('${user.firstName} ${user.lastName}'),
                            ))
                        .toList(),
                    value: selectedTrainer,
                    onChanged: (selectedItem) {
                      setState(() {
                        selectedTrainer = selectedItem as UserForSelection?;
                      });
                      loadReservations();
                    },
                    closeButton: 'Zatvori',
                    searchHint: 'Pretraži trenere',
                    underline: Container(),
                    padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                    displayClearIcon: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: _displayPdf,
                    child: Text(
                      'Prikaži PDF',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _displayPdf() {
    if (selectedUser == null) {
      showErrorDialog(context, 'Odaberite klijenta.');
      return;
    }
    if (reservations.isEmpty) {
      showErrorDialog(context, 'Odabrani klijent nema rezervaacija.');
      return;
    }

    final doc = pw.Document();

    // Maksimalni broj rezervacija po stranici
    final maxReservationsPerPage = 20;

    // Podela rezervacija na stranice
    for (var i = 0; i < reservations.length; i += maxReservationsPerPage) {
      final endIndex = (i + maxReservationsPerPage < reservations.length)
          ? i + maxReservationsPerPage
          : reservations.length;

      final pageReservations = reservations.sublist(i, endIndex);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      child: pw.Image(
                        pw.MemoryImage(
                          File('assets/images/printLogo.png').readAsBytesSync(),
                        ),
                        width: 80,
                        height: 80,
                      ),
                      margin: pw.EdgeInsets.only(right: 20),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Gym Name: ${gym?.name ?? ""}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text('Address: ${gym?.address ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Phone Number: ${gym?.phoneNumber ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Website: ${gym?.website ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Izvjestaj o rezervacijma',
                    style: pw.TextStyle(fontSize: 20),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Izvjestaj o rezervacijma za klijenta ${selectedUser!.firstName} ${selectedUser!.lastName} ',
                  style: pw.TextStyle(fontSize: 12),
                ),
                if (selectedTrainer != null)
                  pw.Text(
                    'Trener:  ${selectedTrainer!.firstName} ${selectedTrainer!.lastName} ',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                // Dodajte tablicu s podacima o rezervacijama
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Vrsta',
                      'Datum',
                      'Pocetak',
                      'Kraj',
                      'Iskoristena'
                    ],
                    for (var reservation in pageReservations)
                      <String>[
                        (reservation.description ?? ""),
                        (_formatDate(reservation.ReservationDate)),
                        '${reservation.StartDate!.hour}:${reservation.StartDate!.minute}0',
                        '${reservation.EndDate!.hour}:${reservation.EndDate!.minute}0',
                        (reservation.isUsed ?? false ? "Da" : "Ne"),
                      ],
                  ],
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                  },
                  border: pw.TableBorder.all(),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  headerHeight: 25,
                  cellHeight: 25,
                ),
                if (endIndex == reservations.length) ...[
                  pw.SizedBox(height: 10),
                  // Dodajte red ispod tabele za prikaz ukupnog broja rezervacija
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('Ukupno rezervacija: ${reservations.length}'),
                      pw.SizedBox(height: 20),
                      pw.Text('Potpis ovlastene osobe'),
                      pw.SizedBox(height: 20),
                      pw.Container(width: 100, child: pw.Divider()),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              ],
            );
          },
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd.MM.yyyy').format(date);
    } else {
      return '';
    }
  }

  void _displayUserPackagesPdf() {
    if (selectedUser1 == null) {
      showErrorDialog(context, 'Odaberite klijenta.');
      return;
    }

    if (_userPackages.isEmpty) {
      showErrorDialog(context, "Odabrani klijent nema clanarina");
      return;
    }
    final doc = pw.Document();

    final maxsPerPage = 20;

    for (var i = 0; i < _userPackages.length; i += maxsPerPage) {
      final endIndex = (i + maxsPerPage < _userPackages.length)
          ? i + maxsPerPage
          : _userPackages.length;

      final pageUserPackages = _userPackages.sublist(i, endIndex);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      child: pw.Image(
                        pw.MemoryImage(
                          File('assets/images/printLogo.png').readAsBytesSync(),
                        ),
                        width: 80,
                        height: 80,
                      ),
                      margin: pw.EdgeInsets.only(right: 20),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Gym Name: ${gym?.name ?? ""}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text('Address: ${gym?.address ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Phone Number: ${gym?.phoneNumber ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Website: ${gym?.website ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Izvjestaj o clanarinama',
                    style: pw.TextStyle(fontSize: 20),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Izvjestaj o clanarinama za klijenta ${selectedUser1!.firstName} ${selectedUser1!.lastName} ',
                  style: pw.TextStyle(fontSize: 12),
                ),
                if (_selectedPackage != null)
                  pw.Text(
                    'Paket:  ${_selectedPackage!.description}',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>['Naziv', 'Pocetak', 'Kraj', 'Iskoristena'],
                    for (var userPackage in pageUserPackages)
                      <String>[
                        (userPackage.package!.description ?? ""),
                        (_formatDate(userPackage.activationDate)),
                        (_formatDate(userPackage.expirationDate)),
                        (userPackage.expired ?? false ? "Da" : "Ne"),
                      ],
                  ],
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                  },
                  border: pw.TableBorder.all(),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  headerHeight: 25,
                  cellHeight: 25,
                ),
                if (endIndex == _userPackages.length) ...[
                  pw.SizedBox(height: 10),
                  // Dodajte red ispod tabele za prikaz ukupnog broja rezervacija
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('Ukupno clanarina: ${_userPackages.length}'),
                      pw.SizedBox(height: 20),
                      pw.Text('Potpis ovlastene osobe'),
                      pw.SizedBox(height: 20),
                      pw.Container(width: 100, child: pw.Divider()),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              ],
            );
          },
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }

  void _displayUserPdf() {
    if (users1.isEmpty) {
      showErrorDialog(context, 'Nema klijenata');
      return;
    }

    final doc = pw.Document();

    final maxsPerPage = 20;

    for (var i = 0; i < users1.length; i += maxsPerPage) {
      final endIndex =
          (i + maxsPerPage < users1.length) ? i + maxsPerPage : users1.length;

      final pageUser = users1.sublist(i, endIndex);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      child: pw.Image(
                        pw.MemoryImage(
                          File('assets/images/printLogo.png').readAsBytesSync(),
                        ),
                        width: 80,
                        height: 80,
                      ),
                      margin: pw.EdgeInsets.only(right: 20),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Gym Name: ${gym?.name ?? ""}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text('Address: ${gym?.address ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Phone Number: ${gym?.phoneNumber ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Website: ${gym?.website ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Izvjestaj o klijentima',
                    style: pw.TextStyle(fontSize: 20),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Aktivnost: ${_selectedIsActive}',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  'Spol: ${selectedGender == null ? 'Svi' : selectedGender == 0 ? 'Muski' : 'Zenski'}',
                  style: pw.TextStyle(fontSize: 12),
                ),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>['Ime i prezime', 'Email', 'Broj', 'Aktivan'],
                    for (var user in pageUser)
                      <String>[
                        '${user.firstName} ${user.lastName}',
                        (user.email),
                        '${user.phoneNumber}',
                        (user.isActive ? "Da" : "Ne"),
                      ],
                  ],
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                  },
                  border: pw.TableBorder.all(),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  headerHeight: 25,
                  cellHeight: 25,
                ),
                if (endIndex == users1.length) ...[
                  pw.SizedBox(height: 10),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('Ukupno korisnika: ${users1.length}'),
                      pw.SizedBox(height: 20),
                      pw.Text('Potpis ovlastene osobe'),
                      pw.SizedBox(height: 20),
                      pw.Container(width: 100, child: pw.Divider()),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              ],
            );
          },
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }

  void _displayUserPaymentsPdf() {
    if (selectedUser2 == null) {
      showErrorDialog(context, 'Odaberite klijenta.');
      return;
    }

    if (_userPackages1.isEmpty) {
      showErrorDialog(context, "Odabrani klijent nema clanarina");
      return;
    }
    final doc = pw.Document();

    final maxsPerPage = 20;

    for (var i = 0; i < _userPackages1.length; i += maxsPerPage) {
      final endIndex = (i + maxsPerPage < _userPackages1.length)
          ? i + maxsPerPage
          : _userPackages1.length;

      final pageUserPayments = _userPackages1.sublist(i, endIndex);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      child: pw.Image(
                        pw.MemoryImage(
                          File('assets/images/printLogo.png').readAsBytesSync(),
                        ),
                        width: 80,
                        height: 80,
                      ),
                      margin: pw.EdgeInsets.only(right: 20),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Gym Name: ${gym?.name ?? ""}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text('Address: ${gym?.address ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Phone Number: ${gym?.phoneNumber ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Website: ${gym?.website ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Izvjestaj o uplatama',
                    style: pw.TextStyle(fontSize: 20),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Izvjestaj o uplatama za klijenta ${selectedUser2!.firstName} ${selectedUser2!.lastName} ',
                  style: pw.TextStyle(fontSize: 12),
                ),
                if (_selectedPackage != null)
                  pw.Text(
                    'Paket:  ${_selectedPackage!.description}',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Naziv',
                      'Datum uplate',
                      'Vrijedi do',
                      'Istekla',
                      'Cijena',
                      'Uplaceno'
                    ],
                    for (var userPackage in pageUserPayments)
                      <String>[
                        (userPackage.package!.description ?? ""),
                        (_formatDate(userPackage.activationDate)),
                        (_formatDate(userPackage.expirationDate)),
                        (userPackage.expired ?? false ? "Da" : "Ne"),
                        '${userPackage.package!.price}0',
                        (_formatCurrency(_calculatePackagePrice(userPackage))),
                      ],
                  ],
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                  },
                  border: pw.TableBorder.all(),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  headerHeight: 25,
                  cellHeight: 25,
                ),
                if (endIndex == _userPackages1.length) ...[
                  pw.SizedBox(height: 10),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('Ukupno uplata: ${_userPackages1.length}'),
                      pw.SizedBox(height: 20),
                      pw.Text('Potpis ovlastene osobe'),
                      pw.SizedBox(height: 20),
                      pw.Container(width: 100, child: pw.Divider()),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              ],
            );
          },
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }

  void _displayPaymentsPdf() {
    if (_userPackagesFromTo.isEmpty) {
      showErrorDialog(context, "Ne postoji ni jedna clanarina");
      return;
    }
    final doc = pw.Document();

    final maxsPerPage = 20;

    for (var i = 0; i < _userPackagesFromTo.length; i += maxsPerPage) {
      final endIndex = (i + maxsPerPage < _userPackagesFromTo.length)
          ? i + maxsPerPage
          : _userPackagesFromTo.length;

      final pagePayments = _userPackagesFromTo.sublist(i, endIndex);

      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      child: pw.Image(
                        pw.MemoryImage(
                          File('assets/images/printLogo.png').readAsBytesSync(),
                        ),
                        width: 80,
                        height: 80,
                      ),
                      margin: pw.EdgeInsets.only(right: 20),
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Gym Name: ${gym?.name ?? ""}',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                        pw.Text('Address: ${gym?.address ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Phone Number: ${gym?.phoneNumber ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Website: ${gym?.website ?? ""}',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    'Izvjestaj o uplatama',
                    style: pw.TextStyle(fontSize: 20),
                  ),
                ),
                pw.SizedBox(height: 10),
                if (_selectedPackage != null)
                  pw.Text(
                    'Paket:  ${_selectedPackage!.description}',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>[
                      'Naziv',
                      'Datum uplate',
                      'Vrijedi do',
                      'Paket',
                      'Cijena',
                      'Uplaceno'
                    ],
                    for (var payment in pagePayments)
                      <String>[
                        (payment.package!.description ?? ""),
                        (_formatDate(payment.activationDate)),
                        (_formatDate(payment.expirationDate)),
                        (payment.package!.name!),
                        '${payment.package!.price}0',
                        (_formatCurrency(_calculatePackagePrice(payment))),
                      ],
                  ],
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                  },
                  border: pw.TableBorder.all(),
                  headerDecoration: pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  headerHeight: 25,
                  cellHeight: 25,
                ),
                if (endIndex == _userPackages1.length) ...[
                  pw.SizedBox(height: 10),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text('Ukupno uplata: ${_userPackages1.length}'),
                      pw.SizedBox(height: 20),
                      pw.Text('Potpis ovlastene osobe'),
                      pw.SizedBox(height: 20),
                      pw.Container(width: 100, child: pw.Divider()),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              ],
            );
          },
        ),
      );
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: 'BAM ');
    return formatter.format(amount);
  }

  double _calculatePackagePrice(UserPackage userPackage) {
    // Calculate the difference between expirationDate and activationDate in months
    int monthsDifference = userPackage.expirationDate!
            .difference(userPackage.activationDate!)
            .inDays ~/
        30;

    // Calculate the total price
    double totalPrice = monthsDifference * userPackage.package!.price!;

    // Apply discounts if necessary
    if (monthsDifference >= 6 && monthsDifference < 12) {
      // 5% discount for more than 6 and less than 12 months
      totalPrice *= 0.95;
    } else if (monthsDifference == 12) {
      // 10% discount for 12 months
      totalPrice *= 0.9;
    }

    return totalPrice;
  }
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Pregled"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }
}
