import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/services/supabase.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get userId => FirebaseAuth.instance.currentUser?.uid ?? '';
  Future<void> createUserProfile({required HerafiModel herafi}) async {
    await _firestore.collection('users').doc(userId).set(herafi.toMap());
  }

  Future<bool> checkUserExists() async {
    final doc = await _firestore.collection('users').doc(userId).get();

    return doc.exists;
  }

  Future<HerafiModel?> getHerafiData() async {
    final doc = await _firestore.collection('users').doc(userId).get();

    return HerafiModel.fromMap(doc.data()!);
  }

  Future<void> updateProfileData({
    required HerafiModel herafi,
    required Uint8List? selectedImage,
  }) async {
    if (userId == null) {
      throw Exception('المستخدم غير مسجل دخول');
    }

    final userRef = _firestore.collection('users').doc(userId);

    // 1. اقرأ الرابط القديم قبل أي تغيير
    final snapshot = await userRef.get();
    final oldImageUrl = snapshot.data()?['imageUrl'] as String?;

    // 2. ارفع الصورة الجديدة لو موجودة
    String? newImageUrl;
    if (selectedImage != null) {
      newImageUrl = await SupabaseService().uploadImage(
        fileBytes: selectedImage,
        fileExtension: 'jpg',
      );
      if (newImageUrl != null) {
        herafi = herafi.copyWith(imageUrl: newImageUrl);
      }
    }

    // 3. حدّث بيانات المستخدم
    await userRef.update(herafi.toMap());

    // 4. امسح القديمة بعد نجاح التحديث
    final shouldDeleteOld =
        newImageUrl != null &&
        oldImageUrl != null &&
        oldImageUrl.isNotEmpty &&
        oldImageUrl != newImageUrl;

    if (shouldDeleteOld) {
      await SupabaseService().deleteImageByUrl(oldImageUrl);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
