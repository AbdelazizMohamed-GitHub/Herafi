import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';

class AuthAppBarWidget extends StatelessWidget {
  const AuthAppBarWidget({super.key, required this.appbarTitle});
  final String appbarTitle;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: HerafiColors.darkBlueColor,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
      ),
      expandedHeight: 280,
      pinned: true,

      // يظهر بعد الـ scroll
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.2,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: appbarTitle, style: HerafiStyles.text26boldWhite),
              TextSpan(text: ' حرفي', style: HerafiStyles.text26boldGold),
            ],
          ),
        ),
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(HerafiImage.logoLight, width: 250, height: 250),
          ],
        ),
      ),
    );
  }
}
