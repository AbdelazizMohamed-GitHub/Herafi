import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/services/supabase.dart';
import 'package:herafi_app/features/profile/domin/model/review_model.dart';

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

  Future<List<ReviewModel>> getReviews({required String herafiId}) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(herafiId)
        .collection('reviews')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => ReviewModel.fromMap(doc.data())).toList();
  }

  Future<bool> hasUserReviewed({required String herafiId}) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return false;

    final review = await _firestore
        .collection('users')
        .doc(herafiId)
        .collection('reviews')
        .doc(currentUserId)
        .get();

    return review.exists;
  }

  Future<void> addReview({
    required String herafiId,
    required String userId,
    required String userName,
    required int rating,
    required String comment,
  }) async {
    if (herafiId.isEmpty || userId.isEmpty) {
      throw ArgumentError('Craftsman and user IDs are required.');
    }
    if (rating < 1 || rating > 5) {
      throw ArgumentError.value(rating, 'rating', 'Must be between 1 and 5.');
    }

    final craftsmanRef = _firestore.collection('users').doc(herafiId);
    final reviewRef = craftsmanRef.collection('reviews').doc(userId);

    await _firestore.runTransaction<void>((transaction) async {
      final craftsmanSnapshot = await transaction.get(craftsmanRef);
     
      if (!craftsmanSnapshot.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'Craftsman profile not found.',
        );
      }

      final data = craftsmanSnapshot.data() ?? <String, dynamic>{};
      final currentRating = (data['rating'] as num?)?.toDouble() ?? 0;
      final currentCount = (data['reviewsCount'] as num?)?.toInt() ?? 0;
      final newCount = currentCount + 1;
      final newRating = ((currentRating * currentCount) + rating) / newCount;

      transaction.set(reviewRef, {
        'userId': userId,
        'userName': userName,
        'rating': rating,
        'comment': comment,
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(craftsmanRef, {
        'rating': double.parse(newRating.toStringAsFixed(1)),
        'reviewsCount': newCount,
      });
    });
  }

  Future<HerafiModel?> getHerafiData() async {
    final doc = await _firestore.collection('users').doc(userId).get();

    return HerafiModel.fromMap(doc.data()!);
  }

  Future<HerafiModel?> getHerafiById({required String herafiId}) async {
    final doc = await _firestore.collection('users').doc(herafiId).get();
    final data = doc.data();

    return data == null ? null : HerafiModel.fromMap(data);
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
    await userRef.update(herafi.toProfileMap());

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
