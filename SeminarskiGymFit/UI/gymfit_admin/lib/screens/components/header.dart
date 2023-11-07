
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
        const ProfileCard(),
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
          color: const Color.fromARGB(255, 255, 167, 43),
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
        const SizedBox(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          child: Text("Armin Idriz"),
        ),
        const Icon(Icons.keyboard_arrow_down),
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
          fillColor: const Color.fromARGB(116, 17, 18, 28),
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(defaultPadding * 0.75),
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              decoration: const BoxDecoration(
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
