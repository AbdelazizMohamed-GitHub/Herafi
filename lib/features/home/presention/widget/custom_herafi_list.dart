import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/features/home/presention/widget/custom_herafi_item_widget.dart';

class CustomHerafiList extends StatelessWidget {
  const CustomHerafiList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 0.8, height: 20);
      },
      itemBuilder: (BuildContext context, int index) {
        return CustomHerafiItemWidget();
      },
    );
  }
}
