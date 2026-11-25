import 'package:flutter/material.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_detail_tile.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_header_widget.dart';

class CustomHerafiDataWidget extends StatelessWidget {
  const CustomHerafiDataWidget({
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
    return Column(
      children: [
        CustomProfileHeaderWidget(
          herafi: herafi,
          onAddReview: onAddReview,
          hasReviewed: hasReviewed,
        ),
        SizedBox(height: 16),
        CustomProfileDetailTileWidget(
          icon: Icons.phone,
          label: 'رقم الهاتف',
          value: herafi.phoneNumber,
          ontap: () {},
        ),

        CustomProfileDetailTileWidget(
          icon: Icons.location_on,
          label: 'الموقع',
          value: herafi.location?.trim().isNotEmpty == true
              ? herafi.location!
              : 'لا يوجد عنوان',
          ontap: () {},
        ),
      ],
    );
  }
}
