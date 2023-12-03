import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';

// ignore: must_be_immutable
class MyreservationsItemWidget extends StatelessWidget {
  const MyreservationsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Teretana: ",
                  style: theme.textTheme.titleMedium,
                ),
                TextSpan(
                  text: "GymFit1",
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 20,
            width: 144,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Trener:",
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: " Ime prezime",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Trener:",
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: " Ime prezime",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
            width: 133,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Datum: ",
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: "09:03.2023",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Datum: ",
                          style: theme.textTheme.titleMedium,
                        ),
                        TextSpan(
                          text: "09:03.2023",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3),
          Padding(
            padding: EdgeInsets.only(left: 2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Vrijeme trajanja: ",
                    style: theme.textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: "18:00-19:00",
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
