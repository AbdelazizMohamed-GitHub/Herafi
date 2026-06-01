import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';

class CustomGoogleFacebookAuthWidget extends StatelessWidget {
  const CustomGoogleFacebookAuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 0.3, color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(HerafiImage.facebook),
                Text('  فيسبوك', style: HerafiStyles.text20Black),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 0.3, color: Colors.black),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(HerafiImage.google),
                Text('  جوجل', style: HerafiStyles.text20Black),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
