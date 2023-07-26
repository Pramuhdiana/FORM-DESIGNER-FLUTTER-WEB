import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustomLoadingButton extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double borderRadiusAll;
  final Color? backgroundColor;
  final Color? successColor;
  final Color? errorColor;
  final Color? splashColor;
  final Widget child;
  final double width;
  final double height;

  const CustomLoadingButton(
      {Key? key,
      required this.controller,
      this.onPressed,
      required this.child,
      this.padding,
      this.borderRadiusAll = 20,
      this.backgroundColor = Colors.blue,
      this.successColor = Colors.green,
      this.errorColor = Colors.red,
      this.elevation = 4,
      this.splashColor,
      this.height = 55,
      this.width = 1450})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      color: backgroundColor,
      successColor: successColor,
      errorColor: errorColor,
      controller: controller,
      onPressed: onPressed,
      valueColor: Colors.white,
      borderRadius: borderRadiusAll,
      height: height,
      width: width,
      child: child,
    );
  }
}
