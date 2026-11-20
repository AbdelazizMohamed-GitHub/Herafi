import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/home/domin/repo/search_repo.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_state.dart'
    show SearchState, SearchInitial, SearchSucess, SearchFailure;

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.searchRepo}) : super(SearchInitial());
  final SearchRepo searchRepo;

  void searchHerafi({
    required String query,
    required List<HerafiModel> allHerafiList,
    required String selectedCategory,
  }) async {
    emit(SearchInitial());
    final result = searchRepo.searchHerafi(
      query: query,
      allHerafiList: allHerafiList,
      selectedCategory: selectedCategory,
    );
    if (result.isEmpty) {
      emit(SearchFailure(errorMessage: 'لا توجد نتائج مطابقة للبحث'));
    } else {
      emit(SearchSucess(searchResults: result));
    }
  }
}
