import 'package:flutter/material.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';

class AppbarTitleImage extends StatefulWidget {
  AppbarTitleImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(key: key);

  final String? imagePath;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;

  @override
  _AppbarTitleImageState createState() => _AppbarTitleImageState();
}

class _AppbarTitleImageState extends State<AppbarTitleImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: CustomImageView(
          imagePath: widget.imagePath,
          height: 40,
          width: 390,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
