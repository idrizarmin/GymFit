import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/image_constant.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';

class HomeItemWidget extends StatefulWidget {
  const HomeItemWidget({Key? key}) : super(key: key);

  @override
  _HomeItemWidgetState createState() => _HomeItemWidgetState();
}

class _HomeItemWidgetState extends State<HomeItemWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomImageView(
      imagePath: ImageConstant.imgSamuelGirven2,
      height: 105,
      width: 95,
      radius: BorderRadius.circular(10),
    );
  }
}
