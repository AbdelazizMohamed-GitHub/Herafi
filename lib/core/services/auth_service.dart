import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }

  Future<bool> hasInternetConnection() => _hasInternetConnection();

  /// SEND OTP
  Future<void> sendOtp({required String phone}) async {
    final hasConnection = await _hasInternetConnection();
    if (!hasConnection) {
      throw FirebaseAuthException(
        code: 'network-request-failed',
        message: 'No Internet Connection.',
      );
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,

      verificationCompleted: (cred) async {
        await _auth.signInWithCredential(cred);
      },

      verificationFailed: (e) {
        throw Exception(e.message);
      },

      codeSent: (verificationId, _) {
        _verificationId = verificationId;
      },

      codeAutoRetrievalTimeout: (id) {
        _verificationId = id;
      },
    );
  }

  /// VERIFY OTP
  Future<UserCredential> verifyOtp({required String otp}) async {
    if (otp.isEmpty) {
      throw Exception('OTP cannot be empty.');
    }
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId ?? '',
      smsCode: otp,
    );

    return await _auth.signInWithCredential(credential);
  }

  User? get currentUser => _auth.currentUser;
  Future<void> logout() async {
    return await _auth.signOut();
  }
}
