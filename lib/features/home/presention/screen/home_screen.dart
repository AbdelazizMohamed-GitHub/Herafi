import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HerafiColors.background,
      appBar: AppBar(
        actions: [
          CircleAvatar(backgroundImage: AssetImage(HerafiImage.profile)),
          SizedBox(width: 12),
        ],
        title: Text("الرئيسية", style: HerafiStyles.text26boldWhite),
        centerTitle: true,
        backgroundColor: HerafiColors.darkBlueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextForm(
                text: 'ادخل اسم الحرفي',
                kType: TextInputType.text,
                pIcon: Icons.person,
                sIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 8),
              child: Text('التصنيفات', style: HerafiStyles.text20Black),
            ),

            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: herfaList.length,

                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: herfaList[index].herfaColor,
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
                          child: Expanded(
                            child: SvgPicture.asset(
                              fit: BoxFit.cover,
                              herfaList[index].herfaImagePath,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(herfaList[index].herfaName),
                    ],
                  );
                },
              ),
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 10,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(thickness: 0.8, height: 20);
              },
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 160,
                  child: Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            height: 180,

                            decoration: BoxDecoration(
                              border: Border.all(width: 0.8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(HerafiImage.profile),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "عبدالعزيز محمد عبدالعزيز",
                                  style: HerafiStyles.text20Black,
                                ),
                                Text(
                                  "مطور تطبيقات",
                                  style: HerafiStyles.text16GoldBold,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text('الشموت - بنها'),
                                        Icon(Icons.location_on),
                                      ],
                                    ),
                                    Container(
                                      width: 80,
                                      height: 40,

                                      decoration: BoxDecoration(
                                        color: HerafiColors.darkBlueColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.phone,
                                        color: HerafiColors.background,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
