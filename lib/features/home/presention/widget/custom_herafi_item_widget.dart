import 'package:flutter/material.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/widget/custom_herafi_jobTitle_widget.dart';

class CustomHerafiItemWidget extends StatelessWidget {
  const CustomHerafiItemWidget({super.key, required this.herafi});
  final HerafiModel herafi;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 7 / 3,

      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(HerafiImage.user, fit: BoxFit.fill),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      herafi.name,
                      style: HerafiStyles.text20Black,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    CustomHerafiJobtitleWidget(jobTitle: herafi.jobTitle),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(herafi.location),
                            Icon(Icons.location_on),
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
                            onPressed: () {},
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
    );
  }
}
