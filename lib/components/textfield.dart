import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final text;
  final hintText;
  final maxLines;
  final controller;
  final validator;
  final onchange;
  final enable;
  final textKeyboardType;
  final prefixIcon;
  final sufixIcon;
  final bool obscurText;
  final String? dateMask;
  const MyTextForm({
    Key? key,
    this.text,
    @required this.hintText,
    this.textKeyboardType,
    this.onchange,
    this.maxLines,
    this.enable,
    this.prefixIcon,
    this.sufixIcon,
    this.obscurText = false,
    @required this.controller,
    this.validator,
    this.dateMask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final dateMaskFormatter = MaskTextInputFormatter(mask: dateMask);
    return TextFormField(
      style: TextStyle(color: Colors.white),
      onChanged: onchange,
      enabled: enable,
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: textKeyboardType,
      controller: controller,
      obscureText: obscurText,
      textInputAction: TextInputAction.done,

      // maxLines: maxLines == null ? null : maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        isDense: true,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
