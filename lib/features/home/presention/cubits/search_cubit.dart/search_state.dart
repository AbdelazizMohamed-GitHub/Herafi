import 'package:herafi_app/app/model/herafi_model.dart';

enum SearchSortOption { newest, rating, distance }

class SearchState {}

class SearchInitial extends SearchState {}

class ChangeSelectedCategory extends SearchState {
  final String selectedCategory;
  ChangeSelectedCategory({required this.selectedCategory});
}

class SearchSucess extends SearchState {
  final List<HerafiModel> searchResults;
  SearchSucess({required this.searchResults});
}

class SearchFailure extends SearchState {
  final String errorMessage;
  SearchFailure({required this.errorMessage});
}
