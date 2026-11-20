import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
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
    emit(OtpResendCooldown(_seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
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
    result.fold((failure) => emit(AuthError(failure: failure)), (_) {
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
      (failure) {
        return emit(AuthError(failure: failure));
      },
      (userCredential) {
        emit(OtpVerified(userCredential: userCredential));
        _timer?.cancel(); // إلغاء المؤقت عند التحقق بنجاح
      },
    );
  }

  Future<void> createAccount({
    required String name,
    required String job,
    required String phoneNumber,
  }) async {
    emit(CreateAccountLoading());
    final userExists = await authRepo.checkUserExists();
    if (userExists) {
      emit(AuthError(failure: Failure(message: 'User already exists.')));
      return;
    }

    final user = HerafiModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      name: name,
      jobTitle: [job],
      location: '',
      phoneNumber: phoneNumber,
      imageUrl: '',
      createdAt: DateTime.now(),
    );

    final result = await authRepo.createAccount(herafi: user);

    result.fold(
      (failure) => emit(AuthError(failure: failure)),
      (_) => emit(CreateAccountSuccess()),
    );
  }
}
