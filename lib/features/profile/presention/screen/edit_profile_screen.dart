import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HerafiColors.background,
      appBar: AppBar(
        title: Text('تعديل الملف الشخصي', style: HerafiStyles.text26boldWhite),
        centerTitle: true,
        backgroundColor: HerafiColors.darkBlueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                        width: 150,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.camera_alt),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CustomTextForm(
                    text: 'تعديل الاسم',
                    kType: TextInputType.text,
                    pIcon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  CustomTextForm(
                    text: 'تعديل الرقم',
                    kType: TextInputType.text,
                    pIcon: Icons.phone,
                  ),
                  SizedBox(height: 16),
                  CustomTextForm(
                    text: 'تعديل الحرفة',
                    kType: TextInputType.text,
                    pIcon: Icons.handyman,
                  ),
                  SizedBox(height: 16),
                  CustomTextForm(
                    text: 'تعديل الموقع',
                    kType: TextInputType.text,
                    pIcon: Icons.location_on,
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    onPressed: () {},
                    text: "حفظ التعديلات",
                    color: HerafiColors.goldColor,
                    textStyle: HerafiStyles.text20White,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
