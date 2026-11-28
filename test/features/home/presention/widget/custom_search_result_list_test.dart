import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:herafi_app/app/di/service_locator.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/services/location_service.dart';
import 'package:herafi_app/features/home/data/repo_impl/search_repo_impl.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/home/presention/widget/custom_search_result_list.dart';

class _FakeLocationService extends LocationService {
  @override
  Future<Position> getCurrentPosition() async => Position(
    latitude: 30,
    longitude: 31,
    timestamp: DateTime.utc(2025),
    accuracy: 0,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: 0,
    speedAccuracy: 0,
  );
}

void main() {
  late SearchCubit searchCubit;

  setUp(() {
    getIt.registerSingleton<LocationService>(_FakeLocationService());
    searchCubit = SearchCubit(searchRepo: SearchRepoImpl())
      ..searchHerafi(
        query: '',
        allHerafiList: [
          _herafi(
            id: 'oldest',
            name: 'Oldest',
            rating: 5,
            createdAt: DateTime.utc(2024),
            latitude: 31,
            longitude: 32,
          ),
          _herafi(
            id: 'newest',
            name: 'Newest',
            rating: 2,
            createdAt: DateTime.utc(2026),
            latitude: 30.001,
            longitude: 31,
          ),
          _herafi(
            id: 'unlocated',
            name: 'Unlocated',
            rating: 3,
            createdAt: DateTime.utc(2025),
          ),
        ],
        selectedCategory: 'الكل',
      );
  });

  tearDown(() async {
    await searchCubit.close();
    await getIt.reset();
  });

  testWidgets('sorts matching results by newest and rating', (tester) async {
    await tester.pumpWidget(_searchScreen(searchCubit));
    expect(_resultNames(tester), ['Newest', 'Unlocated', 'Oldest']);

    await tester.tap(find.text('الأعلى تقييماً'));
    await tester.pumpAndSettle();
    expect(_resultNames(tester), ['Oldest', 'Unlocated', 'Newest']);
  });

  testWidgets('sorts by distance and puts results without coordinates last', (
    tester,
  ) async {
    await tester.pumpWidget(_searchScreen(searchCubit));

    await tester.tap(find.text('الأقرب'));
    await tester.pumpAndSettle();

    expect(_resultNames(tester), ['Newest', 'Oldest', 'Unlocated']);
  });
}

Widget _searchScreen(SearchCubit searchCubit) {
  return BlocProvider<SearchCubit>.value(
    value: searchCubit,
    child:  MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            CustomSearchResultList(
              recentHerafis: [],
              isHistoryLoading: false,
              historyLoadFailed: false,
              onClearHistory: _noop, onHerafiSelected: (HerafiModel value) {  },
            ),
          ],
        ),
      ),
    ),
  );
}

List<String?> _resultNames(WidgetTester tester) {
  return tester
      .widgetList<ListTile>(find.byType(ListTile))
      .map((tile) => (tile.title! as Text).data)
      .toList();
}

HerafiModel _herafi({
  required String id,
  required String name,
  required double rating,
  required DateTime createdAt,
  double? latitude,
  double? longitude,
}) {
  return HerafiModel(
    id: id,
    name: name,
    jobTitle: const ['نجار'],
    location: null,
    latitude: latitude,
    longitude: longitude,
    phoneNumber: '',
    imageUrl: null,
    rating: rating,
    createdAt: createdAt,
  );
}

void _noop() {}
