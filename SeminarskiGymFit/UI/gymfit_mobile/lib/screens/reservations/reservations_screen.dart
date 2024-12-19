import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/reservation.dart';
import 'package:gymfit_mobile/models/searchObjects/reservation_search_object.dart';
import 'package:gymfit_mobile/models/user.dart';
import 'package:gymfit_mobile/models/user_for_selection.dart';
import 'package:gymfit_mobile/providers/login_provider.dart';
import 'package:gymfit_mobile/providers/reservation_provider.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/routes/app_routes.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:gymfit_mobile/widgets/custom_elevated_button.dart';
import 'package:gymfit_mobile/widgets/legend_widget.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  List<UserForSelection> trainers = <UserForSelection>[];
  List<Reservation> reservations = <Reservation>[];
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;
  late ReservationDataSource _events = ReservationDataSource(reservations);
  TextEditingController vectorFifteenController = TextEditingController();
  TextEditingController editTextController = TextEditingController();
  TextEditingController editTextController1 = TextEditingController();
  TextEditingController vectorSeventeenController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int selectedStartHour = 6;
  int selectedEndHour = 7;
  UserForSelection? selectedTrainerToAdd;
  UserForSelection? selectedTrainer;
  final _formKey = GlobalKey<FormState>();
  late UserProvider _userProvider;
  late ReservationProvider _reservationProvider;
  late UserLoginProvider _loginProvider;

  User? user;

  List<String> availableTrainingTypes = [
    'Kardio',
    'Snaga',
    'Kombinovani',
    'Yoga',
    'Pilates',
    'HIIT',
    'CrossFit',
  ];

  late MediaQueryData mediaQueryData;

  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    _reservationProvider = ReservationProvider();
    _loginProvider = context.read<UserLoginProvider>();
    _descriptionController.text = availableTrainingTypes[0];
    loadTrainers();
    loadReservations();
    loadUser();
  }

  void loadReservations() async {
    try {
      ReservationSearchObject searchObject = ReservationSearchObject(
          userId: null, trainerId: selectedTrainer?.id, spol: null);
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

  void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    try {
      var usersResponse = await _userProvider.getById(id!);
      setState(() {
        user = usersResponse;
        print(user!.id);
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void InsertReservation() async {
    try {
      DateTime today = DateTime.now();
      if ((selectedDate.day < today.day &&
          selectedDate.month < today.month &&
          selectedDate.year < today.year)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                            backgroundColor: black,

              title: Text("Greška"),
              content: Text("Odabrani datum nije validan."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
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
      } else if (user?.id == null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: teal,
              title: Text("Greška"),
              content: Text("Pokusajte se ponovno prijaviti."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
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
                         backgroundColor: black,

              title: Text("Greška"),
              content: Text("Niste odabrali trenera."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
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
              backgroundColor: appTheme.bgcolor,
              title: Text("Greška"),
              content: Text("Nepravilno odabrano vrijeme treninga."),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: black,
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
              backgroundColor: black,

              title: const Text("Greška"),
              content: const Text(
                  "Vrijeme rezervacije treba biti minimalno 3 sata od trenutnog vremena!"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
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
          "reservationDate": selectedDate.add(const Duration(days: 1)) .toUtc().toIso8601String(),
          "startDate": startDate.toUtc().toIso8601String(),
          "endDate": endDate.toUtc().toIso8601String(),
          "duration": 0,
          "status": 1,
          "pauseDuration": 0,
          "maxCapacity": 0,
          "daysOfWeek": "string",
          "isUsed": false,
          "gymId": 2,
          "userId": user!.id,
          "trainerId": selectedTrainerToAdd?.id
        };

        var notification = await _reservationProvider.insert(newReservation);

        if (notification == "OK") {
          loadReservations();
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Color(0XFF12B422),
              content: Text('Uspješno ste kreirali rezervciju.',
                  style: TextStyle(
                    color: Colors.white,
                  ))),
        );
          Navigator.of(context).popAndPushNamed(AppRoutes.myReservationsScreen);
        }
      }
    } catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: appTheme.bgSecondary,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(right: 3),
        child: Column(
          children: [
            _buildTitle(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform(
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                child: Column(
                  children: [
                    _buildFilters(),
                    _buildLegend(),
                    _buildClendar(),
                  ],
                ),
              ),
            ),
            _buildAddReservationFields(context),
          ],
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
            Legend('Zauzeto', Colors.red),
            Legend('U tijeku  ', Colors.lightBlue),
          ],
        ),
      ],
    );
  }

  Expanded _buildAddReservationFields(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        dropdownColor: teal,
                        value: _descriptionController.text,
                        onChanged: (value) {
                          setState(() {
                            _descriptionController.text = value!;
                          });
                        },
                        items: availableTrainingTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Vrsta treninga',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _startDateController,
                        decoration: const InputDecoration(
                          labelText: 'Datum',
                          hintText: 'Odaberite datum',
                          labelStyle: TextStyle(color: Colors.white),
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
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
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<int>(
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
                        if (index >= 6) {
                          return DropdownMenuItem<int>(
                            value: index,
                            child: Text('$index:00'),
                          );
                        } else {
                          return null;
                        }
                      }).whereType<DropdownMenuItem<int>>().toList(),
                      decoration: const InputDecoration(
                        labelText: 'Vrijeme početka',
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(
                            color: Colors.white), // Promijenite boju hinta
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      dropdownColor: teal,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: DropdownButtonFormField<int>(
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
                      decoration: const InputDecoration(
                        labelText: 'Vrijeme završetka:',
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(
                            color: Colors.white), // Promijenite boju hinta
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Obavezan unos!';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      dropdownColor: teal,
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
                        const Text(
                          '  Trener: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.white),
                            ),
                          ),
                          child: SearchChoices.single(
                            style: TextStyle(color: white),
                            hint: Text(
                              "Odaberite trenera ",
                              style: TextStyle(color: Colors.white),
                            ),
                            isExpanded: true,
                            items: trainers
                                .map((user) => DropdownMenuItem(
                                      value: user,
                                      child: Text(
                                          '${user.firstName} ${user.lastName}'),
                                    ))
                                .toList(),
                            value: selectedTrainerToAdd,
                            menuBackgroundColor: teal,
                            onChanged: (selectedItem) {
                              setState(() {
                                selectedTrainerToAdd =
                                    selectedItem as UserForSelection?;
                              });
                            },
                            closeButton: 'Zatvori',
                            searchHint: 'Pretraži trenere',
                            underline: Container(),
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            displayClearIcon: true,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildRezervacija(context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildClendar() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: white),
          borderRadius: BorderRadius.circular(10)),
      child: SfCalendar(
        cellBorderColor: const Color.fromARGB(255, 109, 109, 107),
        view: CalendarView.week,
        allowedViews: [
          CalendarView.week,
          CalendarView.timelineMonth,
        ],
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        dataSource: _events,
        firstDayOfWeek: 1,
        timeSlotViewSettings:
            const TimeSlotViewSettings(startHour: 6, endHour: 24),
      ),
    );
  }

  Container _buildTitle() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      decoration: AppDecoration.fillBlack,
      child: Text(
        "Rezervacije",
        style: TextStyle(fontSize: 14, color: white),
      ),
    );
  }

  Row _buildFilters() {
    return Row(
      children: [
        const Text("Filter:"),
        SizedBox(width: 2), // Dodajte razmak između teksta i SearchChoices
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchChoices.single(
                menuBackgroundColor: teal,
                style: TextStyle(color: white),
                hint: Text(
                  "Odaberite trenera ",
                  style: TextStyle(color: Colors.white),
                ),
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
                displayClearIcon: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  

  Widget _buildRezervacija(BuildContext context) {
    return CustomElevatedButton(
      buttonStyle: ElevatedButton.styleFrom(backgroundColor: teal),
      text: "Rezerviši",
      margin: EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          InsertReservation();
          loadReservations();

        }
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
        color: appointmentColor,
      ));
    }

    return appointments;
  }

  Color _getColorForReservationStatus(int status) {
    switch (status) {
      // svaki case crven da bi se predtavile zauzete rezervacije, korisnik ne treba znati status rezervacije
      case 1:
        return Colors.red; //kreirana
      case 2:
        return Colors.red; //potvrdjena
      case 3:
        return Colors.red; //otkazana
      case 4:
        return Colors.red; //zavrseni termini
      default:
        return Colors.red; // Default color if status is unknown
    }
  }
}
