import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImageLoading extends StatelessWidget {
  const CustomImageLoading({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });
  final String? imageUrl;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return imageUrl == null || imageUrl!.isEmpty
        ? Image.asset(
            HerafiImage.emptyUserPicture,
            fit: BoxFit.contain,
            width: width,
            height: height,
          )
        : CachedNetworkImage(
            fit: BoxFit.cover,
            width: width,
            height: height,
            imageUrl: imageUrl!,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Skeletonizer(
                  enabled: true,
                  child: Image.asset(
                    HerafiImage.emptyUserPicture,
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  ),
                ),

            errorWidget: (context, url, error) => Icon(Icons.error),
          );
  }
}
