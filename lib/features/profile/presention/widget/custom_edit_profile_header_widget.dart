import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:herafi_app/app/funcation/funcation.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/core/loading/custom_image_loading.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';

class CustomEditProfileHeaderWidget extends StatefulWidget {
  const CustomEditProfileHeaderWidget({
    super.key,
    required this.imageUrl,
    this.selectedImageCallback,
  });

  final String? imageUrl;
  final Function(Uint8List)? selectedImageCallback;

  @override
  State<CustomEditProfileHeaderWidget> createState() =>
      _CustomEditProfileHeaderWidgetState();
}

class _CustomEditProfileHeaderWidgetState
    extends State<CustomEditProfileHeaderWidget> {
  Uint8List? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: HerafiColors.darkBlueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100,
            child: ClipOval(
              child: selectedImage != null
                  ? Image.memory(
                      selectedImage!,
                      fit: BoxFit.cover,
                      width: 195,
                      height: 195,
                    )
                  : CustomImageLoading(
                      imageUrl: widget.imageUrl,
                      width: 195,
                      height: 195,
                    ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () async {
                await HerafiFunctions.pickImageFromGallery().then((value) {
                  if (value != null) {
                    setState(() {
                      selectedImage = value;
                    });
                    widget.selectedImageCallback?.call(value);
                  } else {
                    CustomSnackBarWidget.show(
                      context,
                      message: 'لم يتم اختيار صورة',
                      type: SnackBarType.warning,
                    );
                  }
                });
              },
              icon: Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
