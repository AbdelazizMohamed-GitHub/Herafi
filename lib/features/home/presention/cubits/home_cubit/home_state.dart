import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class ChangeCategoryState extends HomeState {
  final String selectedCategory;
  ChangeCategoryState({required this.selectedCategory});
}

class GetHomeDataLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HerafiModel> herafiList;
  HomeLoaded({required this.herafiList});
}

class HomeError extends HomeState {
  final Failure failure;
  HomeError({required this.failure});
}
