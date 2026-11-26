import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

class HerfaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<HerafiModel>> getCategoryList({required String category}) async {
    if (category == 'الكل') {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => HerafiModel.fromMap(doc.data()))
          .where((herafi) => herafi.role == HerafiModel.craftsmanRole)
          .toList();
    } else {
      final snapshot = await _firestore
          .collection('users')
          .where('jobTitle', arrayContains: category)
          .get();
      return snapshot.docs
          .map((doc) => HerafiModel.fromMap(doc.data()))
          .where((herafi) => herafi.role == HerafiModel.craftsmanRole)
          .toList();
    }
  }
}
