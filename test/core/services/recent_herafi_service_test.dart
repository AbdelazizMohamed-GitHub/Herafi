import 'package:flutter_test/flutter_test.dart';
import 'package:herafi_app/core/services/recent_herafi_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
    'keeps unique recent IDs in newest-first order and caps the list',
    () async {
      final service = RecentHerafiService(userIdProvider: () => 'user-1');

      for (var index = 1; index <= 11; index++) {
        await service.record('herafi-$index');
      }
      await service.record('herafi-5');

      expect(service.recentHerafiIds, [
        'herafi-5',
        'herafi-11',
        'herafi-10',
        'herafi-9',
        'herafi-8',
        'herafi-7',
        'herafi-6',
        'herafi-4',
        'herafi-3',
        'herafi-2',
      ]);
    },
  );

  test(
    'keeps history separate per user and clears only the active user',
    () async {
      var userId = 'user-1';
      final service = RecentHerafiService(userIdProvider: () => userId);

      await service.record('herafi-1');
      userId = 'user-2';
      await service.load();
      expect(service.recentHerafiIds, isEmpty);

      await service.record('herafi-2');
      await service.clear();
      userId = 'user-1';
      await service.load();

      expect(service.recentHerafiIds, ['herafi-1']);
    },
  );
}
