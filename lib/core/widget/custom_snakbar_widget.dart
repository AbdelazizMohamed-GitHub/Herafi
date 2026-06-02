import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';

class CustomSnackBarWidget {
  static void showWarning(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: HerafiStyles.text20White),
        backgroundColor: HerafiColors.darkBlueColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
