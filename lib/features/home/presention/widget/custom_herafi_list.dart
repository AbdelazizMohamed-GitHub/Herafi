import 'package:flutter/material.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';
import 'package:herafi_app/features/home/presention/widget/custom_herafi_item_widget.dart';

class CustomHerafiList extends StatelessWidget {
  const CustomHerafiList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: dummyHerafiList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 0.8, height: 20);
      },
      itemBuilder: (BuildContext context, int index) {
        return CustomHerafiItemWidget(herafi: dummyHerafiList[index]);
      },
    );
  }
}
