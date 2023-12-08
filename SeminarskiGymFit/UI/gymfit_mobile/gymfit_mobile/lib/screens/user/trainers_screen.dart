import 'dart:convert';
import 'dart:typed_data';

import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/searchObjects/trainer_search_object.dart';
import 'package:gymfit_mobile/models/user.dart';

import 'package:flutter/material.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({Key? key}) : super(key: key);

  @override
  _TrainersScreenState createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late MediaQueryData mediaQueryData;
  List<User> trainers = <User>[];
  late UserProvider _userProvider;
  int currentPage = 1;
  int pageSize = 10;
  int hasNextPage = 0;
  @override
  void initState() {
    super.initState();
    _userProvider = UserProvider();
    loadTrainers();
  }

  void loadTrainers() async {
    try {
      TrainersSearchObject searchObject =
          TrainersSearchObject(PageNumber: currentPage, PageSize: pageSize);

      var usersResponse = await _userProvider.getTrainers(searchObject);
      setState(() {
        trainers = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.bgSecondary,
        body: SizedBox(
          width: mediaQueryData.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Treneri",
                    style: TextStyle(fontSize: 14, color: white),
                  ),
                ),
                _buildTrainersWithInfo(context),
                _buildPagination(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildPagination() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentPage > 1) {
                        setState(() {
                          currentPage--;
                        });
                        loadTrainers();
                      }
                    },
                    icon:
                        Icon(Icons.arrow_left_outlined, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (hasNextPage == pageSize) {
                          currentPage++;
                        }
                      });
                      if (hasNextPage == pageSize) {
                        loadTrainers();
                      }
                    },
                    icon:
                        Icon(Icons.arrow_right_outlined, color: Colors.white),
                  ),
                ],
              );
  }

 

  Widget _buildTrainersWithInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: AppDecoration.fillBlack.copyWith(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          // Dekodiranje Base64 stringa u sliku
          List<int>? imageBytes = trainers[index].profilePhoto != null
              ? base64Decode(trainers[index].profilePhoto!.data)
              : null;

          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  // Postavljanje slike profila korisnika, ako je dostupna, inače postavljamo "notFound.png"
                  backgroundImage: imageBytes != null
                      ? MemoryImage(Uint8List.fromList(imageBytes))
                      : AssetImage('assets/images/notFound.png')
                          as ImageProvider,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        '${trainers[index].firstName} ${trainers[index].lastName}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Bijela boja teksta
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Broj telefona: ${trainers[index].phoneNumber!}',
                        style: TextStyle(
                          color: Colors.white, // Bijela boja teksta
                        ),
                      ),
                      Text(
                        'Email: ${trainers[index].email}',
                        style: TextStyle(
                          color: Colors.white, // Bijela boja teksta
                        ),
                      ),
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
}
