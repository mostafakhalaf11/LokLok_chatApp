// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants.dart';

class CustomFormTextfield extends StatefulWidget {
  String? hintText;
  String? validateMessage;
  void Function(String)? onChanged;
  bool isPassword;

  CustomFormTextfield({
    super.key,
    this.onChanged,
    this.hintText,
    this.validateMessage,
    this.isPassword = false,
  });

  @override
  State<CustomFormTextfield> createState() => _CustomFormTextfieldState();
}

class _CustomFormTextfieldState extends State<CustomFormTextfield> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: widget.isPassword ? obscureText : false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validateMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: kHintTextColor),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
              )
            : null,
      ),
      style: const TextStyle(
        color: kTextColor,
      ),
    );
  }
}
