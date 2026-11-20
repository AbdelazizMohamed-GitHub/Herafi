import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/profile/domin/repo/profile_repo.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());
  final ProfileRepo profileRepo;

  Future<void> getHerafiData() async {
    emit(GetProfileDataLoading());
    final result = await profileRepo.getHerafiData();
    result.fold(
      (failure) => emit(ProfileError(failure: failure)),
      (herafi) => emit(ProfileLoaded(herafi: herafi)),
    );
  }

  Future<void> updateProfileData({
    required HerafiModel herafi,
    Uint8List? selectedImage,
  }) async {
    emit(UpdateProfileDataLoading());
    final result = await profileRepo.updateProfileData(
      herafi: herafi,
      selectedImage: selectedImage,
    );
    result.fold(
      (failure) => emit(ProfileError(failure: failure)),
      (_) => getHerafiData(),
    );
  }

  Future<void> userLogout() async {
    final result = await profileRepo.userLogout();
    result.fold(
      (failure) => emit(ProfileError(failure: failure)),
      (_) => emit(ProfileLoggedOut()),
    );
  }
}
