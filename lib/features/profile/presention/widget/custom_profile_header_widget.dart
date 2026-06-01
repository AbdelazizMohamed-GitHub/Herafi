import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/widget/custom_herafi_jobTitle_widget.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_button.dart';

class CustomProfileHeaderWidget extends StatelessWidget {
  const CustomProfileHeaderWidget({super.key, required this.profile});

  final HerafiModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: HerafiColors.darkBlueColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                profile.imageUrl,
                width: 180,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(profile.name, style: HerafiStyles.text26boldWhite),
          const SizedBox(height: 4),
          CustomHerafiJobtitleWidget(jobTitle: profile.jobTitle),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomProfileButton(
                buttonText: 'اتصال',
                buttonTextStyle: HerafiStyles.text20Black,
                buttonColor: HerafiColors.background,
                buttonIcon: Icon(Icons.phone),
              ),
              SizedBox(width: 12),
              CustomProfileButton(
                buttonText: 'واتس',
                buttonTextStyle: HerafiStyles.text20White,
                buttonColor: HerafiColors.goldColor,
                buttonIcon: SvgPicture.asset(HerafiImage.whatsapp),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
