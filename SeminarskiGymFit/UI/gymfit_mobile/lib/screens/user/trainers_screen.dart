import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/searchObjects/trainer_search_object.dart';
import 'package:gymfit_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:gymfit_mobile/providers/photo_provider.dart';
import 'package:gymfit_mobile/providers/user_provider.dart';
import 'package:gymfit_mobile/utils/authorization.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../providers/login_provider.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({Key? key}) : super(key: key);

  @override
  _TrainersScreenState createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  late MediaQueryData mediaQueryData;
  List<User> trainers = <User>[];
  List<User> recommendedTrainers = <User>[];
  late UserProvider _userProvider;
  late PhotoProvider _photoProvider;
  late UserLoginProvider _loginProvider;
  User? user;


  int currentPage = 1;
  int pageSize = 10;
  int hasNextPage = 0;

  
  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _photoProvider = context.read<PhotoProvider>();
    _loginProvider = context.read<UserLoginProvider>();

    loadTrainers();
    loadUser();
    
  }
void loadUser() async {
    var id = _loginProvider.getUserId();
    print(id);
    try {
      var usersResponse = await _userProvider.getById(id!);
      setState(() {
        user = usersResponse;
      });
      loadRecomendedTrainers(user!.id);
      print(recommendedTrainers);
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadTrainers() async {
    try {
      TrainersSearchObject searchObject =
          TrainersSearchObject(PageNumber: currentPage, PageSize: pageSize);

      var usersResponse = await _userProvider.getTrainersPaged(searchObject);
      setState(() {
        trainers = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  void loadRecomendedTrainers(int userId) async {
    try {
      TrainersSearchObject searchObject =
          TrainersSearchObject(PageNumber: currentPage, PageSize: pageSize);

      var usersResponse = await _userProvider.getRecommended(userId);
      setState(() {
        recommendedTrainers = usersResponse;
      });
    } on Exception catch (e) {
      showErrorDialog(context, e.toString().substring(11));
    }
  }

  Future<String> loadPhoto(String guidId) async {
    return await _photoProvider.getPhoto(guidId);
  }

  @override
Widget build(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  return Scaffold(
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
          icon: Icon(Icons.arrow_left_outlined, color: Colors.white),
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
          icon: Icon(Icons.arrow_right_outlined, color: Colors.white),
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
        final trainer = trainers[index];

        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    width: 90,
                    height: 120,
                    color: primary,
                    child: FutureBuilder<String>(
                      future: trainer.photo != null
                          ? loadPhoto(trainer.photo!.guidId!)
                          : null,
                      builder:
                          (BuildContext context, AsyncSnapshot<String> snapshot) {
                        final imageUrl = snapshot.data;

                        return FadeInImage(
                          image: imageUrl != null && imageUrl.isNotEmpty
                              ? NetworkImage(
                                  imageUrl,
                                  headers: Authorization.createHeaders(),
                                )
                              : AssetImage('assets/images/notFound.png')
                                  as ImageProvider<Object>,
                          placeholder: MemoryImage(kTransparentImage),
                          fadeInDuration: const Duration(milliseconds: 100),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      '${trainer.firstName} ${trainer.lastName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Broj telefona: ${trainer.phoneNumber!}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Email: ${trainer.email}',
                      style: TextStyle(
                        color: Colors.white,
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

 List<Widget> _buildUserList(List<User> users) {
  return users
      .map((user) => Column(
            children: [
              InkWell(
                onTap: () {
                  // Add your navigation logic here
                  // Navigator.pushNamed(context, UserDetailsScreen.routeName, arguments: {'user': user});
                },
                child: user.photo != null
                    ? SimpleShadow(
                        sigma: 4,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: FadeInImage(
                              image: NetworkImage(
                                // loadPhoto(user.photo!.guidId)
                                '$apiUrl/Photos/GetbyId?id=${user.photo!.guidId}&original=true',
                                headers: Authorization.createHeaders(),
                              ),
                              placeholder: MemoryImage(kTransparentImage),
                              height: 210,
                              fadeInDuration: const Duration(milliseconds: 300),
                            ),
                          ),
                        )
                      : const Placeholder(
                          fallbackHeight: 210,
                        ),
                ),
              const SizedBox(
                height: 12,
              ),
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
            
            ],
          ))
      .toList();
}






}
