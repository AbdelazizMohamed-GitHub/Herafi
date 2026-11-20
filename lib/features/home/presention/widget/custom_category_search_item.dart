import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';

class CustomCategorySearchItem extends StatelessWidget {
  const CustomCategorySearchItem({
    super.key,
    required this.index,
    required this.funcation,
    required this.currentIndex,
  });
  final int index;
  final VoidCallback funcation;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcation,
      child: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? HerafiColors.darkBlueColor
              : HerafiColors.background,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          herfaList[index].herfaName,
          style: currentIndex == index
              ? HerafiStyles.text16WhiteBold
              : HerafiStyles.text16BlackBold,
        ),
      ),
    );
    ;
  }
}
