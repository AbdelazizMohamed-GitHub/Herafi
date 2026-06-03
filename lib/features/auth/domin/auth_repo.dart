import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

abstract class AuthRepo {
  Future<void> sendOtp({
    required String phoneNumber,
    required VoidCallback onCodeSent,
    required Function(String error) onError,
  });

  Future<UserCredential> verifyOtp({required String otp});

  Future<void> createAccount(HerafiModel herafi);

  Future<HerafiModel?> getCurrentUser();

  Future<void> logout();
}
