// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:loklokapp/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.onTap, this.buttonLabel});
  String? buttonLabel;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kTextColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
            child: Text(
          '$buttonLabel',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        )),
      ),
    );
  }
}
