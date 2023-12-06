import 'package:gymfit_mobile/helpers/app_decoration.dart';
import 'package:gymfit_mobile/helpers/constants.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/helpers/theme_helper.dart';
import 'package:gymfit_mobile/models/post.dart';
import 'package:gymfit_mobile/providers/post_provider.dart';
import 'package:gymfit_mobile/utils/error_dialog.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String radioGroup = "";
  late MediaQueryData mediaQueryData;
  List<Post> posts = <Post>[];
  late PostProvider _postProvider;

  @override
  void initState() {
    super.initState();
    _postProvider = PostProvider();
    loadPosts();
  }

  void loadPosts() async {
    try {
      var response = await _postProvider.getPaged();
      if (mounted) {
        setState(() {
          posts = response;
        });
      }
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
        appBar: _buildAppbar(context),
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
                    "Početna",
                    style:TextStyle(fontSize: 14, color: white),
                  ),
                ),
                SizedBox(height: 11),
                _buildPosts(context),
                SizedBox(height: 11),
                _buildGymBasics(context),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 19),
                  child: Text(
                    "Galerija",
                    style: CustomTextStyles.titleMedium_1,
                  ),
                ),
                SizedBox(height: 3),
                _buildGallery(context),
                SizedBox(height: 59),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: appTheme.bgSecondary,
      automaticallyImplyLeading: false, // Remove back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo1.png",
            height: 50,
            width: 110,
            fit: BoxFit.contain,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: appTheme.blue,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Form(
                    child: Text("Obavijesti"),
                  );
                });
          },
        ),
      ],
    );
  }

  Widget _buildGymBasics(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: AppDecoration.fillBlack.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BUILD YOUR PERFECT BODY!",
              style: CustomTextStyles.titleLargeOnPrimaryContainerMedium,
            ),
            SizedBox(height: 7),
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          width: double.infinity,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.gym1,
                                height: double.infinity,
                                width: double.infinity,
                                radius: BorderRadius.circular(10),
                                alignment: Alignment.center,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    right: 13,
                                    bottom: 14,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 41),
                                        child: Text(
                                          "01",
                                          style: theme.textTheme.headlineLarge,
                                        ),
                                      ),
                                      Text(
                                        "GRUPNI TRENINZI",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: CustomTextStyles.titleMedium_1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 13),
                        SizedBox(
                          height: 140,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.gym2,
                                height: double.infinity,
                                width: double.infinity,
                                radius: BorderRadius.circular(10),
                                alignment: Alignment.center,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 4,
                                    right: 2,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "03",
                                        style: theme.textTheme.headlineLarge,
                                      ),
                                      Text(
                                        "BALANSIRANA DIJETA",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: CustomTextStyles.titleMedium_1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.gym3,
                            height: double.infinity,
                            width: double.infinity,
                            radius: BorderRadius.circular(10),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 84,
                              width: 93,
                              margin: EdgeInsets.only(bottom: 78),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "INDIVIDUALNI TRENINZI",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: CustomTextStyles.titleMedium_1,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      "02",
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGallery(BuildContext context) {
    List<String> imagePaths = [
      ImageConstant.gallery1,
      ImageConstant.gallery2,
      ImageConstant.gallery3,
      ImageConstant.gallery4,
      ImageConstant.gallery5,
      ImageConstant.gallery6,
      ImageConstant.gallery7,
      ImageConstant.gallery8,
      ImageConstant.gallery9,
      ImageConstant.gallery10,
      ImageConstant.gallery11,
      ImageConstant.gallery12,
      ImageConstant.gallery13,
    ];

    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: AppDecoration.fillBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 200, // Set the desired height of each item
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 10,
            childAspectRatio: 4 / 3,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: imagePaths.length,
          itemBuilder: (context, index) {
            return CustomImageView(
              imagePath: imagePaths[index],
              height: 200,
              width: 150,
              radius: BorderRadius.circular(10),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPosts(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: AppDecoration.fillBlack.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Container(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white, // Set the border color
                  width: 1.0, // Set the border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posts[index].title!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(posts[index].content!),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
