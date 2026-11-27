import 'package:flutter/material.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_detail_tile.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_header_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
          icon: Icons.map_outlined,
          label: 'الموقع',
          value: herafi.location?.trim().isNotEmpty == true
              ? herafi.location!
              : herafi.latitude != null && herafi.longitude != null
              ? 'تم تحديد الموقع على الخريطة'
              : 'لا يوجد عنوان',
          ontap: herafi.latitude == null || herafi.longitude == null
              ? null
              : () async {
                  final latitude = herafi.latitude!;
                  final longitude = herafi.longitude!;
                  final mapUrl = Uri.https('www.openstreetmap.org', '/', {
                    'mlat': '$latitude',
                    'mlon': '$longitude',
                  }).replace(fragment: 'map=16/$latitude/$longitude');
                  final opened = await launchUrl(
                    mapUrl,
                    mode: LaunchMode.externalApplication,
                  );
                  if (!opened && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تعذر فتح الخريطة')),
                    );
                  }
                },
        ),
      ],
    );
  }
}
