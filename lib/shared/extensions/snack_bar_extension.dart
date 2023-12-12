import 'package:flutter/material.dart';

enum SnackBarType { success, error }

extension SnackBarExtension on BuildContext {
  void showSnackBar(SnackBarType snackBarType, String message) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: switch (snackBarType) {
        SnackBarType.success => Colors.green,
        SnackBarType.error => Colors.redAccent,
      },
    ));
  }
}
