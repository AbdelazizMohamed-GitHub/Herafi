import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class GetProfileDataLoading extends ProfileState {}

class UpdateProfileDataLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final HerafiModel herafi;
  final bool hasReviewed;

  ProfileLoaded({required this.herafi, this.hasReviewed = false});
}

class ProfileError extends ProfileState {
  final Failure failure;

  ProfileError({required this.failure});
}

class ProfileLoggedOut extends ProfileState {}
