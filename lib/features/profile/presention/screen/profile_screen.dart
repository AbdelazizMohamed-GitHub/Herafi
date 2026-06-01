import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/user_profile_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_detail_tile.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = currentUserProfile;
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
          ),
          title: Text('الملف الشخصي'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomProfileHeaderWidget(profile: profile),

                  const SizedBox(height: 28),

                  CustomProfileDetailTileWidget(
                    icon: Icons.phone,
                    label: 'رقم الهاتف',
                    value: '01012345678',
                    ontap: () {},
                  ),

                  const SizedBox(height: 16),

                  CustomProfileDetailTileWidget(
                    icon: Icons.location_on,
                    label: 'الموقع',
                    value: 'الشمون - بنها',
                    ontap: () {},
                  ),

                  const SizedBox(height: 32),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        CustomButton(
                          onPressed: () {
                            context.push(HerafiRoutes.editProfile);
                          },
                          text: "تعديل الملف الشخصي",
                          color: HerafiColors.darkBlueColor,
                          textStyle: HerafiStyles.text20White,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          onPressed: () {
                            context.push(HerafiRoutes.welcome);
                          },
                          text: "تسجيل الخروج",
                          color: HerafiColors.goldColor,
                          textStyle: HerafiStyles.text20Black,
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
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
