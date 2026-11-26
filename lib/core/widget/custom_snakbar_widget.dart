import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';

enum SnackBarType { success, error, warning }

class CustomSnackBarWidget {
  static Future<bool?> showToast({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: HerafiColors.darkBlueColor,
      textColor: Colors.white,
    );
  }

  static void show(
    BuildContext context, {
    required String message,
    void Function()? onTap,
    textButton = '',
    SnackBarType type = SnackBarType.warning,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: _backgroundColor(type),
          content: Row(
            children: [
              Icon(_icon(type), color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(textButton, style: HerafiStyles.text14Goldold),
              ),
            ],
          ),
        ),
      );
  }

  static Color _backgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return HerafiColors.darkBlueColor;
    }
  }

  static IconData _icon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
    }
  }
}

void customSnackbarloadingwidget({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: HerafiColors.darkBlueColor,
      content: Row(
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}
