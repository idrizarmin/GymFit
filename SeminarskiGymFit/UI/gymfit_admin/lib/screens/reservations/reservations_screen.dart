import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/reservation.dart';
import 'package:gymfit_admin/models/searchObjects/reservation_search.dart';
import 'package:gymfit_admin/models/user_for_selection.dart';
import 'package:gymfit_admin/providers/reservation_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:search_choices/search_choices.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  List<Reservation> reservations = <Reservation>[];
  List<UserForSelection> users = <UserForSelection>[];
  List<UserForSelection> trainers = <UserForSelection>[];
  UserForSelection? selectedUser;
  UserForSelection? selectedTrainer;
  late UserProvider _userProvider;
  late ReservationProvider _reservationProvider;
  int? selectedGender;
  late ReservationDataSource _events= ReservationDataSource(reservations);
  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    _reservationProvider = ReservationProvider();
    loadUsers();
    loadTrainers();
    loadReservations(ReservationSearchObject());
  }

  void loadReservations(ReservationSearchObject searchObject) async {
    try {
      var notificationsResponse =
          await _reservationProvider.getPaged(searchObject: searchObject);
      if (mounted) {
        setState(() {
          reservations = notificationsResponse;
          print("Rezervacija");
          print(reservations[0].description);

          _events = ReservationDataSource(reservations);
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
          print(users);
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
          print(users);
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: const Heder(pageTitle: "Termini -rezervacije "),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Column(
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
                                    child: Text(
                                        '${user.firstName} ${user.lastName}'),
                                  ))
                              .toList(),
                          value: selectedUser,
                          isExpanded: true,
                          onChanged: (selectedItem) {
                            setState(() {
                              selectedUser = selectedItem as UserForSelection?;
                            });
                          },
                          closeButton: 'Zatvori',
                          searchHint: 'Pretraži korisnike',
                          underline: Container(),
                          padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                          displayClearIcon: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('  Trener:'),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SearchChoices.single(
                          hint: Text("Odaberite trenera"),
                          isExpanded: true,
                          items: trainers
                              .map((user) => DropdownMenuItem(
                                    value: user,
                                    child: Text(
                                        '${user.firstName} ${user.lastName}'),
                                  ))
                              .toList(),
                          value: selectedTrainer,
                          onChanged: (selectedItem) {
                            setState(() {
                              selectedTrainer =
                                  selectedItem as UserForSelection?;
                            });
                          },
                          closeButton: 'Zatvori',
                          searchHint: 'Pretraži trenere',
                          underline: Container(),
                          padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                          displayClearIcon: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
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
                            setState(() {});
                          },
                          underline: Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Dodaj',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Osvježi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white), // Set border color
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SfCalendar(
                  view: CalendarView.week,
                  monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                  dataSource: _events,
                  firstDayOfWeek: 1,
                  timeSlotViewSettings:
                      const TimeSlotViewSettings(startHour: 6, endHour: 24),
                  //dataSource: _events,
                  //  loadMoreWidgetBuilder: (BuildContext context, LoadMoreCallback loadMoreAppointments) {
                  //   return FutureBuilder(future: loadMoreAppointments(), builder: (context, snapShot){
                  //     return Container(
                  //       alignment:  Alignment.center,
                  //       child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(primaryColor)),
                  //     );
                  //   });
                  //  },
                  //specialRegions: _specialTimeRegions,

                  //Klik na kalendar otvara se dialog za dodavanje rezervacije
                  // onTap: (CalendarTapDetails details) {
                  //   if (details.targetElement == CalendarElement.calendarCell) {
                  //     DateTime tappedTime = details.date!;
                  //     _showAppointmentDialog(tappedTime);
                  //   }
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAppointmentDialog(DateTime startTime) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Schedule Appointment'),
          content: Text(
              'Start Time: ${startTime.toString()}'), // Display the start time
          actions: [
            TextButton(
              onPressed: () {
                // Add logic to save the appointment
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class ReservationDataSource extends CalendarDataSource {
  ReservationDataSource(List<Reservation> reservations) {
    appointments = _convertToAppointments(reservations);
  }

  List<Appointment> _convertToAppointments(List<Reservation> reservations) {
  List<Appointment> appointments = [];

  for (var reservation in reservations) {
    Color appointmentColor = Colors.blue;

    // Dodajte logiku za određivanje boje temeljem trenutnog vremena
    DateTime now = DateTime.now();
    if (reservation.StartDate!.isBefore(now) && reservation.EndDate!.isAfter(now)) {
      // Rezervacija je u tijeku
      appointmentColor = Colors.blue;
    } else {
      // Rezervacija nije u tijeku
      appointmentColor = Colors.grey;
    }

    appointments.add(Appointment(
      startTime: reservation.StartDate!,
      endTime: reservation.EndDate!,
      subject: reservation.description,
      color: appointmentColor, // Postavite boju ovisno o stanju rezervacije
    ));
  }

  return appointments;
}
}
