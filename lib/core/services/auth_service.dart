import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  /// SEND OTP
  Future<void> sendOtp({required String phone}) async {
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
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );

    return await _auth.signInWithCredential(credential);
  }

  User? get currentUser => _auth.currentUser;
  Future<void> logout() async {
    return await _auth.signOut();
  }
}
