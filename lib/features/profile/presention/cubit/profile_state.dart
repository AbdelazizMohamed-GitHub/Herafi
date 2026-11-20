import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileDataLoading extends ProfileState {}

class UpdateProfileDataLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final HerafiModel herafi;

  ProfileLoaded({required this.herafi});
}

class ProfileError extends ProfileState {
  final Failure failure;

  ProfileError({required this.failure});
}

class ProfileLoggedOut extends ProfileState {}
