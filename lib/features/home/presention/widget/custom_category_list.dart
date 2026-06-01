import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';

class CustomCategoryList extends StatefulWidget {
  const CustomCategoryList({super.key});

  @override
  State<CustomCategoryList> createState() => _CustomCategoryListState();
}

class _CustomCategoryListState extends State<CustomCategoryList> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: herfaList.length,

      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  alignment: Alignment.center,

                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? HerafiColors.darkBlueColor
                        : herfaList[index].herfaColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      width: 0.5,
                      color: Color.lerp(
                        herfaList[index].herfaColor,
                        Colors.black,
                        0.3,
                      )!,
                    ),
                  ),
                  child: SvgPicture.asset(
                    fit: BoxFit.cover,
                    herfaList[index].herfaImagePath,
                    colorFilter: selectedIndex == index
                        ? const ColorFilter.mode(
                            HerafiColors.goldColor,
                            BlendMode.srcIn,
                          )
                        : null,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              herfaList[index].herfaName,
              style: HerafiStyles.text16BlackBold,
            ),
          ],
        );
      },
    );
  }
}
