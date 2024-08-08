import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      duration: const Duration(seconds: 3),
      content: Text(
        message,
      ),
    ),
  );
}
