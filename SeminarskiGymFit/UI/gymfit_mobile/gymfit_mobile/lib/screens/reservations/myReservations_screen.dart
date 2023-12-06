import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:gymfit_mobile/models/reservation.dart';
import 'package:gymfit_mobile/models/searchObjects/reservation_search_object.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/reservation_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyReservationsScreen extends StatefulWidget {
  const MyReservationsScreen({Key? key}) : super(key: key);

  @override
  _MyReservationsScreenState createState() => _MyReservationsScreenState();
}

class _MyReservationsScreenState extends State<MyReservationsScreen> {
  List<Reservation> reservations = <Reservation>[];
  late MediaQueryData mediaQueryData;
  late ReservationProvider _reservationProvider;
  late UserLoginProvider _loginProvider;
  int _status = 1;
  int? _userId;
  //User? _user;

  @override
  void initState() {
    super.initState();
    _reservationProvider = context.read<ReservationProvider>();
    _loginProvider = context.read<UserLoginProvider>();
    loadUser();
    loadReservations();
  }

  void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    _userId = id;
  }

  void loadReservations() async {
    try {
      loadUser();

      ReservationSearchObject searchObject =
          ReservationSearchObject(userId: _userId, status: _status);
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

  void setReservationAsCanceled(DateTime reservationStartDate) async {
    var today = DateTime.now();

    int hoursDifference = reservationStartDate.difference(today).inHours;

    if (today.day == reservationStartDate.day &&
        today.month == reservationStartDate.month &&
        today.year == reservationStartDate.year) {
      if (hoursDifference >= 3) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Rezervacija otkazana'),
              content: const Text('Uspješno ste otkazali vašu rezervaciju.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Upozorenje'),
              content: const Text(
                  'Nije moguće otkazati rezervaciju manje od 3 sata prije termina.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Otkazivanje rezervacije'),
            content:
                const Text('Da li ste sigurni da želite otkazati rezervaciju?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Zatvori'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Otkaži'),
              ),
            ],
          );
        },
      );
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
                  "Moje rezervacije",
                  style: TextStyle(fontSize: 14, color: white),
                ),
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusButton(1, "Kreirane"),
                  _buildStatusButton(2, "Potvrđene"),
                  _buildStatusButton(4, "Završene"),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Column(
                      children: [_buildReservationInfo(context)],
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

  ElevatedButton _buildStatusButton(int status, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _status == status ? Colors.teal : null,
      ),
      onPressed: () {
        setState(() {
          _status = status;
          loadReservations();
        });
      },
      child: Text(
        label,
        style: TextStyle(color: white),
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

  Widget _buildReservationInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: AppDecoration.fillBlack.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: reservations.length,
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
                      if (reservations[index].Trainer != null) ...[
                        Text(
                          'Trener: ${reservations[index].Trainer!.firstName} ${reservations[index].Trainer!.lastName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text color
                          ),
                        ),
                      ],
                      _buildReservaationData('Datum:',
                          '${_formatDate(reservations[index].ReservationDate)}'),
                      _buildReservaationData('Vrsta treninga: ',
                          '${reservations[index].description?.toString()}'),
                      _buildReservaationData('Početak: ',
                          '${reservations[index].StartDate?.hour.toString()}:00'),
                      _buildReservaationData('Kraj: ',
                          '${reservations[index].EndDate?.hour.toString()}:00'),
                      if (_status == 2)
                        ElevatedButton(
                          onPressed: () {
                            setReservationAsCanceled(
                                reservations[index].StartDate!);
                          },
                          child: Text('Otkaži'),
                        ),
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

  Widget _buildReservaationData(String label, String value) {
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
}
