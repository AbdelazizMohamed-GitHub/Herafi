import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';

class CustomEditProfileHeaderWidget extends StatelessWidget {
  const CustomEditProfileHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HerafiColors.darkBlueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100,
            child: ClipOval(
              child: Image.asset(
                HerafiImage.user,
                // width: 150,
                // height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
          ),
        ],
      ),
    );
  }
}
