import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/user_profile_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/profile/presention/widget/profile_detail_tile.dart';
import 'package:herafi_app/features/profile/presention/widget/profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = currentUserProfile;

    return Scaffold(
      backgroundColor: HerafiColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text('الملف الشخصي', style: HerafiStyles.text26boldWhite),
        centerTitle: true,
        backgroundColor: HerafiColors.darkBlueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeaderWidget(profile: profile),
            const SizedBox(height: 24),
            ProfileDetailTile(
              ontap: () {},
              icon: Icons.phone,
              label: 'رقم الهاتف',
              value: profile.phone,
            ),
            ProfileDetailTile(
              icon: Icons.location_on,
              label: 'الموقع',
              value: profile.location,
              ontap: () {},
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                onPressed: () {},
                text: 'تعديل الملف الشخصي',
                color: HerafiColors.darkBlueColor,
                textStyle: HerafiStyles.text20White,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                onPressed: () => context.go(HerafiRoutes.signIn),
                text: 'تسجيل الخروج',
                color: HerafiColors.goldColor,
                textStyle: HerafiStyles.text20Black,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
