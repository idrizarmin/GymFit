
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gymfit_admin/helpers/constants.dart';

class Heder extends StatelessWidget {
  const Heder({
    Key? key,
    required this.pageTitle,
  }) : super(key: key);

  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/icons/entry.svg",
          color: Colors.white,
          height: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            pageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ProfileCard(),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        SvgPicture.asset(
          "assets/icons/notification2.svg",
          color: Color.fromARGB(255, 255, 167, 43),
          width: 35,
          height: 35,
        ),
        const SizedBox(width: 15),
        ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Adjust the radius as needed
          child: Image.asset(
            "assets/images/user1.jpg",
            height: 38,
          ),
        ),
        SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          child: Text("Armin Idriz"),
        ),
        Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Potraži teretanu",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: Color.fromARGB(116, 17, 18, 28),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(defaultPadding * 0.75),
              margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
