import 'package:flutter/material.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/reservation.dart';
import 'package:gymfit_admin/models/searchObjects/reservation_search.dart';
import 'package:gymfit_admin/models/user_for_selection.dart';
import 'package:gymfit_admin/providers/reservation_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:gymfit_admin/widgets/legend_widget.dart';
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
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  UserForSelection? selectedUser;
  UserForSelection? selectedTrainer;
  UserForSelection? selectedUserToAdd;
  UserForSelection? selectedTrainerToAdd;
  late UserProvider _userProvider;
  late ReservationProvider _reservationProvider;
  int? selectedGender;
  bool showAddReservationForm = false;
  int selectedStartHour = 6;
  int selectedEndHour = 7;
  late ReservationDataSource _events = ReservationDataSource(reservations);
  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    _reservationProvider = ReservationProvider();
    loadUsers();
    loadTrainers();
    loadReservations();
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

  void InsertReservation() async {
    try {
      DateTime today = DateTime.now();
      if ((selectedDate.day < today.day)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: dialogColor,
              title: Text("Greška"),
              content: Text("Odabrani datum nije validan."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else if (selectedUserToAdd == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: dialogColor,
              title: Text("Greška"),
              content: Text("Niste odabrali klijenta."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else if (selectedTrainerToAdd == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: dialogColor,
              title: Text("Greška"),
              content: Text("Niste odabrali trenera."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else if (selectedStartHour > selectedEndHour ||
          selectedStartHour == selectedEndHour) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: dialogColor,
              title: Text("Greška"),
              content: Text("Nepravilno odabrano vrijeme treninga."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else if ((selectedStartHour < today.hour + 3 ||
              selectedStartHour > selectedEndHour ||
              selectedStartHour == selectedEndHour) &&
          (selectedDate.day == today.day &&
              selectedDate.month == today.month &&
              selectedDate.year == today.year)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: dialogColor,
              title: const Text("Greška"),
              content: const Text(
                  "Vrijeme rezervacije treba biti minimalno 3 sata od trenutnog vremena!"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        startDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, (selectedStartHour + 1));
        endDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, (selectedEndHour + 1));

        var newReservation = {
          "id": 0,
          "description": _descriptionController.text,
          "reservationDate": selectedDate.toUtc().toIso8601String(),
          "startDate": startDate.toUtc().toIso8601String(),
          "endDate": endDate.toUtc().toIso8601String(),
          "duration": 0,
          "status": 1,
          "pauseDuration": 0,
          "maxCapacity": 0,
          "daysOfWeek": "string",
          "isUsed": false,
          "gymId": 2,
          "userId": selectedUserToAdd!.id,
          "trainerId": selectedTrainerToAdd?.id
        };

        var notification = await _reservationProvider.insert(newReservation);

        if (notification == "OK") {
          loadReservations();
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
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
              child: const Header(pageTitle: "Termini -rezervacije "),
            ),
            const SizedBox(height: 16.0),
            buildFilters(),
            const SizedBox(height: 16.0),
            buildButtons(context),
            const SizedBox(height: 10.0),
            _buildLegend(),
            _buildCalendar(),
          ],
        ),
      ),
    );
  }

  Expanded _buildCalendar() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white), // Set border color
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SfCalendar(
          view: CalendarView.week,
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          dataSource: _events,
          firstDayOfWeek: 1,
          timeSlotViewSettings:
              const TimeSlotViewSettings(startHour: 6, endHour: 24),
        ),
      ),
    );
  }

  Row _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LegendsListWidget(
          legends: [
            Legend('Kreirane', Colors.brown),
            Legend(
              'Potvrđene',
              Colors.green,
            ), // Boja za status 2
            Legend(
              'Otkazane',
              Colors.orange,
            ), // Boja za status 3
            Legend('Zavrsene', Colors.red),
            Legend('U tijeku  ', Colors.lightBlue),
          ],
        ),
      ],
    );
  }

  Row buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: dialogColor,
                        title: Text("Dodaj rezervaciju"),
                        content: SingleChildScrollView(
                          child: AddReservationForm(),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Zatvori",
                                  style: TextStyle(color: white))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  InsertReservation();
                                }
                              },
                              child: Text("Spremi",
                                  style: TextStyle(color: white)))
                        ],
                      );
                    });
              },
              child: Row(
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
              onPressed: () {
                loadReservations();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
    );
  }

  Row buildFilters() {
    return Row(
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
                    setState(() {
                      selectedGender = newValue;
                      loadReservations();
                    });
                  },
                  underline: Container(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget AddReservationForm({
    bool isEditing = false,
    Reservation? reservationToEdit,
  }) {
    if (reservationToEdit != null) {
    } else {}

    return Container(
      height: 450,
      width: 950,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration:
                              InputDecoration(labelText: 'Vrsta treninga'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _startDateController,
                          decoration: InputDecoration(
                            labelText: 'Datum',
                            hintText: 'Odaberite datum',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                                _startDateController.text =
                                    "${pickedDate.day}.${pickedDate.month}.${pickedDate.year}.";
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          hint: Text("Vrijeme pocetka"),
                          onChanged: (newValue) {
                            setState(() {
                              selectedStartHour = newValue!;
                              startDate = DateTime(selectedDate.year,
                                  selectedDate.month, selectedStartHour);
                              endDate = DateTime(selectedDate.year,
                                  selectedDate.month, selectedEndHour);
                            });
                          },
                          items: List.generate(24, (index) {
                            // Dodajte uslov za prikaz samo radnih sati (od 06 do 24)
                            if (index >= 6) {
                              return DropdownMenuItem<int>(
                                value: index,
                                child: Text('$index:00'),
                              );
                            } else {
                              return null;
                            }
                          }).whereType<DropdownMenuItem<int>>().toList(),
                          decoration: InputDecoration(
                            labelText: 'vrijeme početka',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          hint: Text("Vrijeme završetka"),
                          onChanged: (newValue) {
                            setState(() {
                              selectedEndHour = newValue!;
                              startDate = DateTime(selectedDate.year,
                                  selectedDate.month, selectedStartHour);
                              endDate = DateTime(selectedDate.year,
                                  selectedDate.month, selectedEndHour);
                            });
                          },
                          items: List.generate(24, (index) {
                            if (index >= 6) {
                              return DropdownMenuItem<int>(
                                value: index,
                                child: Text('$index:00'),
                              );
                            } else {
                              return null;
                            }
                          }).whereType<DropdownMenuItem<int>>().toList(),
                          decoration: InputDecoration(
                            labelText: 'Vrijeme završetka:',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Obavezan unos!';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('  Korisnik:'),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: SearchChoices.single(
                                hint: Text("Odaberite korisnika"),
                                isExpanded: true,
                                items: users
                                    .map((user) => DropdownMenuItem(
                                          value: user,
                                          child: Text(
                                              '${user.firstName} ${user.lastName}'),
                                        ))
                                    .toList(),
                                value: selectedUserToAdd,
                                onChanged: (selectedItem) {
                                  setState(() {
                                    selectedUserToAdd =
                                        selectedItem as UserForSelection?;
                                  });
                                },
                                closeButton: 'Zatvori',
                                searchHint: 'Pretraži klijente',
                                underline: Container(),
                                padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                                displayClearIcon: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
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
                                value: selectedTrainerToAdd,
                                onChanged: (selectedItem) {
                                  setState(() {
                                    selectedTrainerToAdd =
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
                    ],
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

class ReservationDataSource extends CalendarDataSource {
  ReservationDataSource(List<Reservation> reservations) {
    appointments = _convertToAppointments(reservations);
  }

  List<Appointment> _convertToAppointments(List<Reservation> reservations) {
    List<Appointment> appointments = [];

    for (var reservation in reservations) {
      Color appointmentColor =
          _getColorForReservationStatus((reservation.status!));

      DateTime now = DateTime.now();
      if (reservation.StartDate!.isBefore(now) &&
          reservation.EndDate!.isAfter(now)) {
        appointmentColor = Colors.blue;
      }

      appointments.add(Appointment(
        startTime: reservation.StartDate!,
        endTime: reservation.EndDate!,
        subject: reservation.description!,
        color: appointmentColor,
      ));
    }

    return appointments;
  }

  Color _getColorForReservationStatus(int status) {
    switch (status) {
      case 1:
        return Colors.brown; //kreirana
      case 2:
        return Colors.green; //potvrdjena
      case 3:
        return Colors.orange; //otkazana
      case 4:
        return Colors.red; //zavrseni termini
      default:
        return Colors.blue; // Default color if status is unknown
    }
  }
}
