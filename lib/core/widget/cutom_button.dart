// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.textStyle,
  });
  final void Function()? onPressed;
  final String text;
  final Color color;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: textStyle),
    );
  }
}
