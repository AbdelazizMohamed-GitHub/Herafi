import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/features/home/presention/widget/custom_category_list.dart';
import 'package:herafi_app/features/home/presention/widget/custom_herafi_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HerafiColors.background,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => context.push(HerafiRoutes.profile),
            child: const CircleAvatar(
              backgroundImage: AssetImage(HerafiImage.profile),
            ),
          ),
          const SizedBox(width: 12),
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

            SizedBox(height: 80, child: CustomCategoryList()),
            CustomHerafiList(),
          ],
        ),
      ),
    );
  }
}
