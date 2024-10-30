// import 'package:bookme/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeTextField extends StatelessWidget {
  CustomPinCodeTextField({
    super.key,
    required this.context,
    required this.onChanged,
    this.alignment,
    this.controller,
    this.textStyle,
    this.hintStyle,
    this.validator,
  });

  final Alignment? alignment;

  final BuildContext context;

  final TextEditingController? controller;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  Function(String) onChanged;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: pinCodeTextFieldWidget,
          )
        : pinCodeTextFieldWidget;
  }

  Widget get pinCodeTextFieldWidget => PinCodeTextField(
        backgroundColor: Colors.white,
        appContext: context,
        controller: controller,
        length: 6,
        keyboardType: TextInputType.number,
        textStyle: textStyle,
        hintStyle: hintStyle,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        pinTheme: PinTheme(
          disabledColor: const Color.fromRGBO(9, 54, 96, 1),
          inactiveFillColor: Colors.red,
          fieldHeight: 38,
          fieldWidth: 45,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          selectedColor: const Color.fromRGBO(9, 54, 96, 1),
          // selectedColor: appTheme.gray400,
          inactiveColor: Colors.transparent,
          activeColor: Colors.transparent,
          // activeFillColor: const Color.fromARGB(255, 0, 0, 13
          // )
        ),
        onChanged: (value) => onChanged(value),
        validator: validator,
      );
}
