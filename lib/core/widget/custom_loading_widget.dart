import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: HerafiColors.darkBlueColor),
    );
  }
}
