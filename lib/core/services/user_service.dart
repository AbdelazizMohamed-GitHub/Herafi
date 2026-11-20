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

    if (selectedImage != null) {
      ;
      await SupabaseService()
          .uploadImage(fileBytes: selectedImage, fileExtension: 'jpg')
          .then((imageUrl) {
            if (imageUrl != null) {
              herafi = herafi.copyWith(imageUrl: imageUrl);
            }
          })
          .catchError((error) {
            throw Exception('Error uploading image: $error');
          });
    }
    await _firestore.collection('users').doc(userId).update(herafi.toMap());
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
