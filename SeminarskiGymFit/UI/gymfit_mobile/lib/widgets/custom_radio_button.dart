import 'package:flutter/material.dart';
import 'package:gymfit_mobile/helpers/custom_text_style.dart';

// ignore: must_be_immutable
class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({
    Key? key,
    required this.onChange,
    this.decoration,
    this.alignment,
    this.isRightCheck,
    this.iconSize,
    this.value,
    this.groupValue,
    this.text,
    this.width,
    this.padding,
    this.textStyle,
    this.textAlignment,
    this.gradient,
    this.backgroundColor,
  }) : super(key: key);

  final BoxDecoration? decoration;
  final Alignment? alignment;
  final bool? isRightCheck;
  final double? iconSize;
  String? value;
  final String? groupValue;
  final Function(String) onChange;
  final String? text;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextAlign? textAlignment;
  final Gradient? gradient;
  final Color? backgroundColor;

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
            alignment: widget.alignment ?? Alignment.center,
            child: buildRadioButtonWidget,
          )
        : buildRadioButtonWidget;
  }

  bool get isGradient => widget.gradient != null;
  BoxDecoration get gradientDecoration => BoxDecoration(gradient: widget.gradient);
  Widget get buildRadioButtonWidget => InkWell(
        onTap: () {
          widget.onChange(widget.value!);
        },
        child: Container(
          decoration: widget.decoration,
          width: widget.width,
          padding: widget.padding,
          child: (widget.isRightCheck ?? false)
              ? rightSideRadioButton
              : leftSideRadioButton,
        ),
      );
  Widget get leftSideRadioButton => Row(
        children: [
          Padding(
            child: radioButtonWidget,
            padding: EdgeInsets.only(right: 8),
          ),
          textWidget,
        ],
      );
  Widget get rightSideRadioButton => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textWidget,
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: radioButtonWidget,
          ),
        ],
      );
  Widget get textWidget => Text(
        widget.text ?? "",
        textAlign: widget.textAlignment ?? TextAlign.center,
        style: widget.textStyle ?? CustomTextStyles.bodyMediumErrorContainer,
      );
  Widget get radioButtonWidget => SizedBox(
        height: widget.iconSize,
        width: widget.iconSize,
        child: Radio<String>(
          visualDensity: VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          value: widget.value ?? "",
          groupValue: widget.groupValue,
          onChanged: (value) {
            widget.onChange(value!);
          },
        ),
      );
  BoxDecoration get radioButtonDecoration =>
      BoxDecoration(color: widget.backgroundColor);
}
