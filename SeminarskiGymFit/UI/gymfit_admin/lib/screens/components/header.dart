import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:gymfit_admin/helpers/constants.dart';
import 'package:gymfit_admin/providers/login_provider.dart';
import 'package:provider/provider.dart';

class Heder extends StatefulWidget {
  const Heder({
    Key? key,
    required this.pageTitle,
  }) : super(key: key);

  final String pageTitle;

  @override
  _HederState createState() => _HederState();
}

class _HederState extends State<Heder> {
  late LoginProvider _loginProvider;

  @override
  void initState() {
    super.initState();
    _loginProvider = context.read<LoginProvider>();
  }

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
            widget.pageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        ProfileCard(loginProvider: _loginProvider),
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  final LoginProvider loginProvider;

  const ProfileCard({
    Key? key,
    required this.loginProvider,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {


  

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
        
      ],
    );
  }
}
