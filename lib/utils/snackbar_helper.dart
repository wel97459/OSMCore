import 'global_keys.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, {bool isError = false}) {
  scaffoldMessengerKey.currentState?.clearSnackBars();
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : null,
      duration: isError ? const Duration(seconds: 4) : const Duration(seconds: 2),
    ),
  );
}