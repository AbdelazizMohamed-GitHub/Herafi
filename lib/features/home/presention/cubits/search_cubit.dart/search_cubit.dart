import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/home/domin/repo/search_repo.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_state.dart'
    show
        SearchState,
        SearchInitial,
        SearchSucess,
        SearchFailure,
        SearchSortOption;

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(SearchInitial());
  final SearchRepo searchRepo;

  SearchSortOption _sortOption = SearchSortOption.newest;
  double? _currentLatitude;
  double? _currentLongitude;
  List<HerafiModel> _searchResults = [];

  void clearSearch() {
    _searchResults = [];
    emit(SearchInitial());
  }

  void searchHerafi({
    required String query,
    required List<HerafiModel> allHerafiList,
    required String selectedCategory,
  }) {
    emit(SearchInitial());
    final result = searchRepo.searchHerafi(
      query: query,
      allHerafiList: allHerafiList,
      selectedCategory: selectedCategory,
    );
    _searchResults = result;
    if (result.isEmpty) {
      emit(SearchFailure(errorMessage: 'لا توجد نتائج مطابقة للبحث'));
    } else {
      emit(SearchSucess(searchResults: _sortResults(result)));
    }
  }

  void sortSearchResults({
    required SearchSortOption sortOption,
    double? currentLatitude,
    double? currentLongitude,
  }) {
    _sortOption = sortOption;
    if (currentLatitude != null && currentLongitude != null) {
      _currentLatitude = currentLatitude;
      _currentLongitude = currentLongitude;
    }

    final currentState = state;
    if (currentState is SearchSucess) {
      emit(SearchSucess(searchResults: _sortResults(_searchResults)));
    }
  }

  List<HerafiModel> _sortResults(List<HerafiModel> results) {
    final indexedResults = results.asMap().entries.toList();
    indexedResults.sort((first, second) {
      final comparison = switch (_sortOption) {
        SearchSortOption.newest => second.value.createdAt.compareTo(
          first.value.createdAt,
        ),
        SearchSortOption.rating => second.value.rating.compareTo(
          first.value.rating,
        ),
        SearchSortOption.distance => _compareDistance(
          first.value,
          second.value,
        ),
      };
      return comparison == 0 ? first.key.compareTo(second.key) : comparison;
    });
    return indexedResults.map((entry) => entry.value).toList();
  }

  int _compareDistance(HerafiModel first, HerafiModel second) {
    return _distanceFromCurrentPosition(
      first,
    ).compareTo(_distanceFromCurrentPosition(second));
  }

  double _distanceFromCurrentPosition(HerafiModel herafi) {
    final latitude = herafi.latitude;
    final longitude = herafi.longitude;
    final currentLatitude = _currentLatitude;
    final currentLongitude = _currentLongitude;
    if (latitude == null ||
        longitude == null ||
        currentLatitude == null ||
        currentLongitude == null ||
        !latitude.isFinite ||
        !longitude.isFinite ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      return double.infinity;
    }

    return Geolocator.distanceBetween(
      currentLatitude,
      currentLongitude,
      latitude,
      longitude,
    );
  }
}
