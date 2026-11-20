import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HerafiFunctions {
  static final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');

  static String formatEgyptPhone(String phone) {
    phone = phone.trim().replaceAll(' ', '');

    // Already E.164
    if (phone.startsWith('+20')) {
      return phone;
    }

    // Remove Egyptian local 0
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }

    return '+20$phone';
  }

  static Future<void> openWhatsApp(String phoneNumber) async {
    final formattedNumber = formatEgyptPhone(phoneNumber);
    final Uri url = Uri.parse('https://wa.me/$formattedNumber');

    final bool launched = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      throw Exception('Could not launch WhatsApp');
    }
  }

  static Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
    );

    if (image == null) {
      return null;
    }
    print('Picked image path: ${image.path}');

    final CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'قص الصورة',
          toolbarColor: HerafiColors.darkBlueColor,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'قص الصورة', aspectRatioLockEnabled: true),
      ],
    );

    if (croppedImage == null) {
      return null;
    }

    return await croppedImage.readAsBytes();
  }
}
