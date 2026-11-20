import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/herafi_app.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/features/home/domin/repo/home_repo.dart';
import 'package:herafi_app/features/home/presention/cubits/home_cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepo}) : super(HomeInitial());
  final HomeRepo homeRepo;
  String selectedCategory = 'الكل';
  List<HerafiModel> allHerafiList = []; // المتغير لتخزين قائمة الحرفيين

  // المتغير لتخزين التصنيف المحدد
  Future<void> setSelectedCategory(String category) async {
    selectedCategory = category;
    emit(ChangeCategoryState(selectedCategory: selectedCategory));
    await getHomeData();
  }

  Future<void> getHomeData() async {
    emit(GetHomeDataLoading());
    final result = await homeRepo.getHomeData(category: selectedCategory);
    result.fold((failure) => emit(HomeError(failure: failure)), (herafiList) {
      if (selectedCategory == 'الكل') {
        allHerafiList = herafiList;
      }
      emit(HomeLoaded(herafiList: herafiList));
    });
  }
}
