import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/screens/components/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int ukupnoClanova = 100;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  child: const Header(pageTitle: "Dashboard")),
              SizedBox(
                height: 14,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width),
                          child: Container(
                              child: Column(children: [
                            Row(
                              children: [
                                StatsBuilder("assets/icons/users1.svg",
                                    "Ukupan broj clanova", ukupnoClanova),
                                SizedBox(
                                  width: 14,
                                ),
                                StatsBuilder("assets/icons/activeUser.svg",
                                    "Aktivni clanovi", ukupnoClanova),
                                SizedBox(
                                  width: 14,
                                ),
                                StatsBuilder("assets/icons/unactiveUser.svg",
                                    "Neaktivni clanovi", ukupnoClanova),
                                SizedBox(
                                  width: 14,
                                ),
                                StatsBuilder("assets/icons/calendar.svg",
                                    "Rezervacije ovaj mjesec", ukupnoClanova),
                              ],
                            ),
                            // BarChart(
                            //   BarChartData(

                            //       // titlesData: FlTitlesData(
                            //       //   leftTitles: SideTitles(
                            //       //     reservedSize: 30,
                            //       //     getTextStyles: (value) => const TextStyle(
                            //       //       color: Colors.grey,
                            //       //       fontSize: 12,
                            //       //     ),
                            //       //     showTitles: true,
                            //       //     getTitles: (value) {
                            //       //       if (value == 0) {
                            //       //         return '0';
                            //       //       } else if (value == 30) {
                            //       //         return '30k';
                            //       //       }  else if (value == 60) {
                            //       //         return '60k';
                            //       //       }  else if (value == 90) {
                            //       //         return '90k';
                            //       //       } else {
                            //       //         return '';
                            //       //       }
                            //       //     },
                            //       //   ),
                            //       //   bottomTitles: SideTitles(
                            //       //     showTitles: true,
                            //       //     getTextStyles: (value) => const TextStyle(
                            //       //       color: Colors.grey,
                            //       //       fontSize: 12,
                            //       //     ),
                            //       //     getTitles: (value) {
                            //       //       if (value == 0) {
                            //       //         return 'JAN';
                            //       //       } else if (value == 1) {
                            //       //         return 'FEB';
                            //       //       }  else if (value == 2) {
                            //       //         return 'MAR';
                            //       //       }  else if (value == 3) {
                            //       //         return 'APR';
                            //       //       } else if (value == 4) {
                            //       //         return 'MAY';
                            //       //       }  else if (value == 5) {
                            //       //         return 'JUN';
                            //       //       }  else if (value == 6) {
                            //       //         return 'JUL';
                            //       //       }  else if (value == 7) {
                            //       //         return 'AUG';
                            //       //       }  else if (value == 8) {
                            //       //         return 'SEP';
                            //       //       }  else if (value == 9) {
                            //       //         return 'OCT';
                            //       //       }  else if (value == 10) {
                            //       //         return 'NOV';
                            //       //       }  else if (value == 11) {
                            //       //         return 'DEC';
                            //       //       }  else {
                            //       //         return '';
                            //       //       }
                            //       //     },
                            //       //   ),
                            //       // ),
                            //       barGroups: [
                            //         BarChartGroupData(x: 0, barRods: [
                            //           BarChartRodData(
                            //               toY: 10,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20),
                            //         ]),
                            //         BarChartGroupData(x: 1, barRods: [
                            //           BarChartRodData(
                            //               toY: 50,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 2, barRods: [
                            //           BarChartRodData(
                            //             toY: 30,
                            //             color: Colors.black,
                            //           )
                            //         ]),
                            //         BarChartGroupData(x: 3, barRods: [
                            //           BarChartRodData(
                            //               toY: 80,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 4, barRods: [
                            //           BarChartRodData(
                            //               toY: 70,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 5, barRods: [
                            //           BarChartRodData(
                            //               toY: 20,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 6, barRods: [
                            //           BarChartRodData(
                            //               toY: 90,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 7, barRods: [
                            //           BarChartRodData(
                            //               toY: 60,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 8, barRods: [
                            //           BarChartRodData(
                            //               toY: 90,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 9, barRods: [
                            //           BarChartRodData(
                            //               toY: 10,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 10, barRods: [
                            //           BarChartRodData(
                            //               toY: 40,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //         BarChartGroupData(x: 11, barRods: [
                            //           BarChartRodData(
                            //               toY: 80,
                            //               color: Colors.black,
                            //               borderRadius:
                            //                   BorderRadius.circular(0),
                            //               width: 20)
                            //         ]),
                            //       ]),
                            //   swapAnimationDuration:
                            //       Duration(milliseconds: 150), // Optional
                            //   swapAnimationCurve: Curves.linear, // Optional
                            // )
                          ])))))
            ])));
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
            SizedBox(
              height: 5,
            ),
            PrimaryText(text: label, color: Colors.white, size: 16),
            PrimaryText(
              text: num.toString(),
              size: 20,
              fontWeight: FontWeight.w700,
            )
          ],
        )),
  );
}
