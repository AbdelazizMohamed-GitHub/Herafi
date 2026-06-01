import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class CustomEditProfileBodyWidget extends StatelessWidget {
  const CustomEditProfileBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
