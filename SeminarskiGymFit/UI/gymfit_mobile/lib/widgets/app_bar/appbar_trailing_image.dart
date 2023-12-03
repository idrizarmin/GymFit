import 'package:flutter/material.dart';
import 'package:gymfit_mobile/widgets/custom_image_view.dart';

class AppbarTrailingImage extends StatefulWidget {
  AppbarTrailingImage({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(key: key);

  final String? imagePath;
  final EdgeInsetsGeometry? margin;
  final Function? onTap;

  @override
  _AppbarTrailingImageState createState() => _AppbarTrailingImageState();
}

class _AppbarTrailingImageState extends State<AppbarTrailingImage> {
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
          height: 30,
          width: 390,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
