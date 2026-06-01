import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';

class CustomHerafiJobtitleWidget extends StatelessWidget {
  const CustomHerafiJobtitleWidget({super.key, required this.jobTitle});
  final List jobTitle;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,

      children: jobTitle.asMap().entries.map((entry) {
        int index = entry.key;
        String title = entry.value;

        return Text(
          index < jobTitle.length - 1 ? '$title &' : title,
          style: HerafiStyles.text16GoldBold,
        );
      }).toList(),
    );
  }
}
