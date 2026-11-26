import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentHerafiService extends ChangeNotifier {
  RecentHerafiService({String? Function()? userIdProvider})
    : _userIdProvider =
          userIdProvider ?? (() => FirebaseAuth.instance.currentUser?.uid);

  static const int maxRecentHerafis = 10;
  static const String _storageKeyPrefix = 'recent_herafi_ids_';

  final String? Function() _userIdProvider;
  List<String> _recentHerafiIds = [];
  String? _loadedStorageKey;

  List<String> get recentHerafiIds => List.unmodifiable(_recentHerafiIds);

  String get _storageKey => '$_storageKeyPrefix${_userIdProvider() ?? 'guest'}';

  Future<void> load() async {
    final storageKey = _storageKey;
    final preferences = await SharedPreferences.getInstance();
    _recentHerafiIds = preferences.getStringList(storageKey) ?? [];
    _loadedStorageKey = storageKey;
    notifyListeners();
  }

  Future<void> record(String herafiId) async {
    if (herafiId.trim().isEmpty) {
      throw ArgumentError.value(herafiId, 'herafiId', 'Cannot be empty.');
    }

    final storageKey = _storageKey;
    final preferences = await SharedPreferences.getInstance();
    final recentIds = _loadedStorageKey == storageKey
        ? List<String>.of(_recentHerafiIds)
        : preferences.getStringList(storageKey) ?? <String>[];

    recentIds.remove(herafiId);
    recentIds.insert(0, herafiId);
    if (recentIds.length > maxRecentHerafis) {
      recentIds.removeRange(maxRecentHerafis, recentIds.length);
    }

    await preferences.setStringList(storageKey, recentIds);
    _recentHerafiIds = recentIds;
    _loadedStorageKey = storageKey;
    notifyListeners();
  }

  Future<void> clear() async {
    final storageKey = _storageKey;
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(storageKey);

    _recentHerafiIds = [];
    _loadedStorageKey = storageKey;
    notifyListeners();
  }
}
