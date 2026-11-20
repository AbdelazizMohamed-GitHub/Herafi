import 'package:dartz/dartz.dart';
import 'package:herafi_app/app/failure/herafi_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/model/herfa_model.dart';
import 'package:herafi_app/features/home/domin/repo/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  @override
  List<HerafiModel> searchHerafi({
    required String query,
    required List<HerafiModel> allHerafiList,
    required String selectedCategory,
  }) {
    // Filter the list of HerafiModel based on the search query and selected category
    final filteredList = allHerafiList.where((herafi) {
      final matchesQuery = herafi.name.toLowerCase().contains(
        query.toLowerCase(),
      );
      final matchesCategory =
          selectedCategory == 'الكل' ||
          herafi.jobTitle.toList().contains(selectedCategory);
      return matchesQuery && matchesCategory;
    }).toList();

    return filteredList;
  }
}
