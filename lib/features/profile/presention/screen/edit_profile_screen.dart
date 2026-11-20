import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_edit_profile_body_widget.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_edit_profile_header_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.herafi});
  final HerafiModel herafi;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
        ),
        title: Text('تعديل الملف الشخصي'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomEditProfileHeaderWidget(
              imageUrl: widget.herafi.imageUrl,
              selectedImageCallback: (selectedImage) {
                setState(() {
                  this.selectedImage = selectedImage;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CustomEditProfileBodyWidget(
                herafi: widget.herafi,
                selectedImage: selectedImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
