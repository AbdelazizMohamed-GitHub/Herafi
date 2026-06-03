import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

class UserService {
  UserService._();

  static final UserService instance = UserService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserProfile({required HerafiModel herafi}) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('المستخدم غير مسجل دخول');
    }

    await _firestore.collection('users').doc(user.uid).set(herafi.toMap());
  }

  Future<bool> userExists() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final doc = await _firestore.collection('users').doc(user.uid).get();

    return doc.exists;
  }

  Future<HerafiModel?> getUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();

    return HerafiModel.fromMap(doc.data()!);
  }

  Future<void> updateUserProfile({required HerafiModel herafi}) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('المستخدم غير مسجل دخول');
    }

    await _firestore.collection('users').doc(user.uid).update(herafi.toMap());
  }
}
