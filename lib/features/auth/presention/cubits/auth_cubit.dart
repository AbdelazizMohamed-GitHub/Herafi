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
  int _seconds = 30;
  bool _isResendActive = false;
  bool _canEditPhone = true;

  bool get isResendActive => _isResendActive;
  int get resendSeconds => _seconds;
  bool get canEditPhone => _canEditPhone;

  void startResendTimer() {
    _seconds = 30;
    _isResendActive = true;
    _canEditPhone = false;

    _timer?.cancel();
    emit(OtpResendCooldown(_seconds));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 1) {
        _seconds = 0;
        _isResendActive = false;
        timer.cancel();
        _timer = null;
        _canEditPhone = true;
        emit(OtpResendReady());
      } else {
        _seconds--;
        emit(OtpResendCooldown(_seconds));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _timer = null;
    _isResendActive = false;
    return super.close();
  }

  /// =========================
  /// SEND OTP
  /// =========================
  Future<void> sendOtp(String phone) async {
    emit(OtpLoading());

    final result = await authRepo.sendOtp(phoneNumber: phone);
    result.fold(
      (failure) {
        _canEditPhone = true;
        emit(AuthError(failure: failure));
      },
      (_) {
        _canEditPhone = false;
        emit(OtpSent(isSent: true));
        startResendTimer();
      },
    );
  }

  /// =========================
  /// VERIFY OTP
  /// =========================
  Future<void> verifyOtp(String otp) async {
    final hasConnection = await authRepo.hasInternetConnection();
    if (!hasConnection) {
      emit(
        AuthError(failure: const Failure(message: 'No Internet Connection.')),
      );
      return;
    }

    emit(VerifyOtpLoading());

    final result = await authRepo.verifyOtp(otp: otp);

    result.fold(
      (failure) {
        return emit(AuthError(failure: failure));
      },
      (userCredential) {
        _timer?.cancel();
        _timer = null;
        _isResendActive = false;
        emit(OtpVerified(userCredential: userCredential));
      },
    );
  }

  Future<void> createAccount({
    required String name,
    required String role,
    required String job,
    required String phoneNumber,
  }) async {
    emit(CreateAccountLoading());
    final userExists = await authRepo.checkUserExists();
    if (userExists) {
      _canEditPhone = true;

      emit(AuthError(failure: Failure(message: 'User already exists.')));
      return;
    }

    final user = HerafiModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      name: name,
      role: role,
      jobTitle: role == HerafiModel.craftsmanRole ? [job] : [],
      location: '',
      phoneNumber: phoneNumber,
      imageUrl: '',
      createdAt: DateTime.now(),
    );

    final result = await authRepo.createAccount(herafi: user);

    result.fold((failure) {
      _canEditPhone = true;
      emit(AuthError(failure: failure));
    }, (_) => emit(CreateAccountSuccess()));
  }
}
