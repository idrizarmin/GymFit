import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/helpers/show_error_dialog.dart';
import 'package:gymfit_admin/models/searchObjects/bar_chart_search.dart';
import 'package:gymfit_admin/providers/reservation_provider.dart';
import 'package:gymfit_admin/providers/user_provider.dart';
import 'package:gymfit_admin/screens/components/header.dart';
import 'package:gymfit_admin/widgets/legend_widget.dart';

List<double> data = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
int currentYear = DateTime.now().year;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ReservationProvider _reservationProvider;
  late UserProvider _userProvider;
  int reservationsThisMOnth = 0;
  int countOfUsers = 0;
  int countOfUsersActive = 0;
  int countOfUsersINactive = 0;
  final cyclingColor = Colors.cyan;

  @override
  void initState() {
    super.initState();
    _reservationProvider = ReservationProvider();
    _userProvider = UserProvider();
    loadReservations();
    loadUsers();
    loadActiveUsers();
    loadInactiveUsers();
    loadReservationsOfMonth();
  }

  void loadReservations() async {
    try {
      BarChartSearchObject searchObject =
          BarChartSearchObject(year: currentYear);
      var response = await _reservationProvider.getByMonth(searchObject);
      if (mounted) {
        setState(() {
          data = response.map((value) => (value as num).toDouble()).toList();
        
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadUsers() async {
    try {
      var response = await _userProvider.getCountOfUsers();
      if (mounted) {
        setState(() {
          countOfUsers = response;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }
 void loadReservationsOfMonth() async {
    try {
      var response = await _reservationProvider.getCountOfReservations();
      if (mounted) {
        setState(() {
          reservationsThisMOnth = response;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }
  void loadActiveUsers() async {
    try {
      var response = await _userProvider.getCountOfUsersActive();
      if (mounted) {
        setState(() {
          countOfUsersActive = response;
        });
      }
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadInactiveUsers() async {
    try {
      var response = await _userProvider.getCountOfUsersInactive();
      if (mounted) {
        setState(() {
          countOfUsersINactive = response;
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
              child: const Header(pageTitle: "Dashboard"),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            StatsBuilder(
                              "assets/icons/users1.svg",
                              "Ukupan broj clanova",
                              countOfUsers,
                            ),
                            SizedBox(width: 14),
                            StatsBuilder(
                              "assets/icons/activeUser.svg",
                              "Aktivni clanovi",
                              countOfUsersActive,
                            ),
                            SizedBox(width: 14),
                            StatsBuilder(
                              "assets/icons/unactiveUser.svg",
                              "Neaktivni clanovi",
                              countOfUsersINactive,
                            ),
                            SizedBox(width: 14),
                            StatsBuilder(
                              "assets/icons/calendar.svg",
                              "Rezervacije ovaj mjesec",
                              reservationsThisMOnth,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Column(
                              children: [
                                BarChartMonths(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          currentYear--;
                                        });
                                        loadReservations();
                                      },
                                      icon: Icon(Icons.arrow_left),
                                      color: myWhite,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      currentYear.toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          currentYear++;
                                        });
                                        loadReservations();
                                      },
                                      icon: Icon(Icons.arrow_right),
                                      color: myWhite,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartMonths extends StatelessWidget {
  BarChartMonths({Key? key}) : super(key: key);

  final cyclingColor = Colors.cyan;
  final betweenSpace = 0.2;
  final maxData = data.isNotEmpty
      ? data.reduce((value, element) => value > element ? value : element)
      : 0.0;

  BarChartRodData generateRodData(
    double y,
    Color color,
  ) {
    return BarChartRodData(
      toY: y,
      color: color,
      width: 40,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(6),
        topRight: Radius.circular(6),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEB';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'APR';
        break;
      case 4:
        text = 'MAY';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AUG';
        break;
      case 8:
        text = 'SEP';
        break;
      case 9:
        text = 'OCT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEC';
        break;
      default:
        text = '';
    }
    return Text(text, style: style);
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    return Text(value.toInt().toString(), style: style);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Broj rezervacija po mjesecu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        LegendsListWidget(
          legends: [
            Legend('Broj rezervacija', cyclingColor),
          ],
        ),
        AspectRatio(
          aspectRatio: 2,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: leftTitles,
                  ),
                ),
                rightTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: bottomTitles,
                    reservedSize: 40,
                  ),
                ),
              ),
              barTouchData: BarTouchData(enabled: false),
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barsSpace: 3,
                  barRods: [generateRodData(data[0], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 1,
                  barsSpace: 3,
                  barRods: [generateRodData(data[1], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 2,
                  barsSpace: 3,
                  barRods: [generateRodData(data[2], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 3,
                  barsSpace: 3,
                  barRods: [generateRodData(data[3], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 4,
                  barsSpace: 3,
                  barRods: [generateRodData(data[4], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 5,
                  barsSpace: 3,
                  barRods: [generateRodData(data[5], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 6,
                  barsSpace: 3,
                  barRods: [generateRodData(data[6], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 7,
                  barsSpace: 3,
                  barRods: [generateRodData(data[7], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 8,
                  barsSpace: 3,
                  barRods: [generateRodData(data[8], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 9,
                  barsSpace: 0,
                  barRods: [generateRodData(data[9], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 10,
                  barsSpace: 0,
                  barRods: [generateRodData(data[10], cyclingColor)],
                ),
                BarChartGroupData(
                  x: 11,
                  barsSpace: 0,
                  barRods: [generateRodData(data[11], cyclingColor)],
                ),
              ],
              maxY: maxData,
            ),
          ),
        ),
      ],
    );
  }
}

Expanded StatsBuilder(String icon, String label, int num) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(defaultPadding),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: 35,
            color: Colors.white,
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
          Text(
            num.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )
        ],
      ),
    ),
  );
}
