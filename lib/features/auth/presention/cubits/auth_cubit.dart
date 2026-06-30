import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/auth/domin/auth_repo.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  String? phoneNumber;
  Timer? _timer;
  int _seconds = 60;
  void startResendTimer() {
    _seconds = 60;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
        emit(OtpSent()); // رجوع للحالة الطبيعية
      } else {
        _seconds--;
        emit(OtpResendCooldown(_seconds));
      }
    });
  }

  /// =========================
  /// SEND OTP
  /// =========================
  Future<void> sendOtp(String phone) async {
    emit(OtpLoading());

    final result = await authRepo.sendOtp(phoneNumber: phone);

    result.fold((failure) => emit(AuthError(massageFailure: failure.message)), (
      _,
    ) {
      emit(OtpSent());
      startResendTimer(); // 🔥 يبدأ العد
    });
  }

  /// =========================
  /// VERIFY OTP
  /// =========================
  Future<void> verifyOtp(String otp) async {
    emit(VerifyOtpLoading());

    final result = await authRepo.verifyOtp(otp: otp);

    result.fold(
      (failure) => emit(AuthError(massageFailure: failure.message)),
      (userCredential) => emit(OtpVerified(userCredential: userCredential)),
    );
  }

  /// =========================
  /// CREATE ACCOUNT
  /// =========================
  Future<void> createAccount({
    required String name,
    required String job,
    required String phoneNumber,
  }) async {
    emit(CreateAccountLoading());

    final user = HerafiModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      name: name,
      jobTitle: [job],
      location: '',
      phone: phoneNumber,
      imageUrl: '',
      createdAt: DateTime.now(),
    );

    final result = await authRepo.createAccount(herafi: user);

    result.fold(
      (failure) => emit(AuthError(massageFailure: failure.message)),
      (_) => emit(CreateAccountSuccess()),
    );
  }

  /// =========================
  /// GET USER
  /// =========================
  Future<void> getUser() async {
    emit(AuthLoading());

    final result = await authRepo.getCurrentUser();

    result.fold((failure) => emit(AuthError(massageFailure: failure.message)), (
      user,
    ) {
      if (user != null) {
        emit(UserLoaded(user: user));
      } else {
        emit(AuthInitial());
      }
    });
  }

  /// =========================
  /// LOGOUT
  /// =========================
  Future<void> logout() async {
    await authRepo.logout();
    emit(AuthInitial());
  }
}
