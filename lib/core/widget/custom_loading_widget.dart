import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 100),
        Center(
          child: CircularProgressIndicator(color: HerafiColors.darkBlueColor),
        ),
      ],
    );
  }
}
