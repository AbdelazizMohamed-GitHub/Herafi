import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/loading/custom_image_loading.dart';
import 'package:herafi_app/core/widget/custom_herafi_jobtitle_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomHerafiItemWidget extends StatelessWidget {
  const CustomHerafiItemWidget({super.key, required this.herafi});
  final HerafiModel herafi;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(HerafiRoutes.profile, extra: herafi);
      },
      child: AspectRatio(
        aspectRatio: 10 / 3,

        child: Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 5,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CustomImageLoading(
                        imageUrl: herafi.imageUrl,
                        width: 120,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            herafi.name,
                            style: HerafiStyles.text16BlackBold,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Spacer(),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${herafi.rating.toStringAsFixed(1)} (${herafi.reviewsCount})',
                            style: HerafiStyles.text14BlackBold,
                          ),
                        ],
                      ),
                      CustomHerafiJobtitleWidget(jobTitle: herafi.jobTitle),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  herafi.location?.trim().isNotEmpty == true
                                      ? herafi.location!
                                      : 'لا يوجد عنوان',
                                  style: HerafiStyles.text14BlackBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 80,
                            height: 40,

                            decoration: BoxDecoration(
                              color: HerafiColors.darkBlueColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () {
                                final Uri phoneUrl = Uri.parse(
                                  'tel:${herafi.phoneNumber}',
                                );

                                launchUrl(phoneUrl);
                              },
                              icon: const Icon(
                                Icons.phone,
                                color: HerafiColors.background,
                              ),
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
      ),
    );
  }
}
