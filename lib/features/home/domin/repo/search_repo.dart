import 'package:herafi_app/app/model/herafi_model.dart';

abstract class SearchRepo {
  List<HerafiModel> searchHerafi({
    required String query,
    required List<HerafiModel> allHerafiList,
    required String selectedCategory,
  });
}
