import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';

class HerafiTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: HerafiColors.darkBlueColor,
    scaffoldBackgroundColor: HerafiColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: HerafiColors.darkBlueColor,
      centerTitle: true,
      titleTextStyle: HerafiStyles.text26boldWhite,
    ),
  );
  // static final ThemeData darkTheme = ThemeData.dark().copyWith(

  //   primaryColor: AppColors.primaryColor,
  //   scaffoldBackgroundColor: AppColors.backgroundDarkColor,
  //   appBarTheme: const AppBarTheme(
  //       backgroundColor: AppColors.secondaryDarkColor,
  //       centerTitle: true,
  //       titleTextStyle: AppStyles.text26BoldWhite),
  // );

  static bool isLightTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;
}
