import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_edit_profile_body_widget.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_edit_profile_header_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
            CustomEditProfileHeaderWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomEditProfileBodyWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
