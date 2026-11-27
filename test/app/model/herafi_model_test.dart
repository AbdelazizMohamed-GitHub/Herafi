import 'package:flutter_test/flutter_test.dart';
import 'package:herafi_app/app/model/herafi_model.dart';

void main() {
  test('round-trips optional map coordinates through the profile map', () {
    final createdAt = DateTime.utc(2025, 1, 1);
    final herafi = HerafiModel(
      id: 'craftsman-1',
      name: 'Craftsman',
      jobTitle: const ['نجار'],
      location: null,
      latitude: 30.0444,
      longitude: 31.2357,
      phoneNumber: '01000000000',
      imageUrl: null,
      createdAt: createdAt,
    );

    final restored = HerafiModel.fromMap(herafi.toMap());

    expect(restored.latitude, 30.0444);
    expect(restored.longitude, 31.2357);
  });

  test('loads profiles saved before coordinates were added', () {
    final herafi = HerafiModel.fromMap({
      'id': 'craftsman-1',
      'name': 'Craftsman',
      'jobTitle': ['نجار'],
      'phoneNumber': '01000000000',
      'createdAt': DateTime.utc(2025, 1, 1).toIso8601String(),
    });

    expect(herafi.latitude, isNull);
    expect(herafi.longitude, isNull);
  });
}
