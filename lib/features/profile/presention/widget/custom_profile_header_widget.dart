import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:herafi_app/app/funcation/funcation.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/widget/custom_herafi_jobtitle_widget.dart';
import 'package:herafi_app/core/loading/custom_image_loading.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomProfileHeaderWidget extends StatelessWidget {
  const CustomProfileHeaderWidget({
    super.key,
    required this.herafi,
    this.onAddReview,
    this.hasReviewed = false,
  });

  final HerafiModel herafi;
  final VoidCallback? onAddReview;
  final bool hasReviewed;

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
            radius: 100,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: CustomImageLoading(
                imageUrl: herafi.imageUrl,
                width: 195,
                height: 195,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(herafi.name, style: HerafiStyles.text26boldWhite),
          const SizedBox(height: 4),
         
          if (herafi.role == HerafiModel.craftsmanRole)
            CustomHerafiJobtitleWidget(jobTitle: herafi.jobTitle),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${herafi.rating.toStringAsFixed(1)} (${herafi.reviewsCount})',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              if (onAddReview != null)
                TextButton.icon(
                  onPressed: onAddReview,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                  ),
                  icon: const Icon(Icons.rate_review_outlined, size: 18),
                  label: const Text('أضف تقييم'),
                ),
              if (hasReviewed)
                TextButton.icon(
                  onPressed: null,
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(
                    'تم التقييم',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomProfileButton(
                buttonText: 'اتصال',
                buttonTextStyle: HerafiStyles.text20Black,
                buttonColor: HerafiColors.background,
                buttonIcon: Icon(Icons.phone),
                onTap: () {
                  final Uri phoneUrl = Uri.parse('tel:${herafi.phoneNumber}');

                  launchUrl(phoneUrl);
                },
              ),
              SizedBox(width: 12),
              CustomProfileButton(
                buttonText: 'واتس',
                buttonTextStyle: HerafiStyles.text20White,
                buttonColor: HerafiColors.goldColor,
                buttonIcon: SvgPicture.asset(HerafiImage.whatsapp),
                onTap: () async {
                  await HerafiFunctions.openWhatsApp(herafi.phoneNumber);
                  // Handle WhatsApp button tap
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
