import 'package:bookme/presentation/widget/base_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends BaseButton {
  // bool loading = false;
  CustomElevatedButton({
    super.key,
    // Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.loading = false,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    this.radiusinput,
    Color? backgroundColorBtn,
    // bool? ,
    required super.text,
  }) : super(color: backgroundColorBtn);

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final double? radiusinput;

  bool? loading = false;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 57,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle ??
              ElevatedButton.styleFrom(
                backgroundColor: color ?? const Color.fromRGBO(9, 54, 96, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      radiusinput ?? 7.0), // Set your desired radius here
                ),
                // Other style properties
              ),
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              loading == false
                  ? Text(
                      text,
                      style: buttonTextStyle ??
                          const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins'),
                    )
                  : const CircularProgressIndicator(),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
