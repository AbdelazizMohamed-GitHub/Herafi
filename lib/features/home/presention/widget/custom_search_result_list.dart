import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/di/service_locator.dart';
import 'package:herafi_app/app/failure/location_failure.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/core/loading/custom_image_loading.dart';
import 'package:herafi_app/core/services/location_service.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_state.dart';

extension on SearchSortOption {
  String get label => switch (this) {
        SearchSortOption.newest => 'الأحدث',
        SearchSortOption.rating => 'الأعلى تقييماً',
        SearchSortOption.distance => 'الأقرب',
      };
}

class CustomSearchResultList extends StatefulWidget {
  const CustomSearchResultList({
    super.key,
    required this.recentHerafis,
    required this.isHistoryLoading,
    required this.historyLoadFailed,
    required this.onClearHistory,
    required this.onHerafiSelected,
  });

  final List<HerafiModel> recentHerafis;
  final bool isHistoryLoading;
  final bool historyLoadFailed;
  final VoidCallback onClearHistory;
  final ValueChanged<HerafiModel> onHerafiSelected;

  @override
  State<CustomSearchResultList> createState() => _CustomSearchResultListState();
}

class _CustomSearchResultListState extends State<CustomSearchResultList> {
  final LocationService _locationService = getIt<LocationService>();
  SearchSortOption _sortOption = SearchSortOption.newest;
  bool _isLocating = false;

  void _openHerafi(HerafiModel herafi) {
    FocusScope.of(context).unfocus();
    widget.onHerafiSelected(herafi);
    context.push(HerafiRoutes.profile, extra: herafi);
  }

  Future<void> _selectSortOption(SearchSortOption option) async {
    if (option != SearchSortOption.distance) {
      setState(() => _sortOption = option);
      context.read<SearchCubit>().sortSearchResults(sortOption: option);
      return;
    }

    setState(() => _isLocating = true);

    try {
      final position = await _locationService.getCurrentPosition();
      if (!mounted) return;

      setState(() => _sortOption = option);
      context.read<SearchCubit>().sortSearchResults(
            sortOption: option,
            currentLatitude: position.latitude,
            currentLongitude: position.longitude,
          );
    } on CurrentLocationException catch (error) {
      if (!mounted) return;
      LocationFailure.show(
        context: context,
        failure: error.failure,
        locationService: _locationService,
      );
    } finally {
      if (mounted) {
        setState(() => _isLocating = false);
      }
    }
  }

  Widget _buildSortChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Wrap(
          spacing: 8,
          runSpacing: 4,
          children: SearchSortOption.values.map((option) {
            final isDistanceLoading =
                _isLocating && option == SearchSortOption.distance;

            return ChoiceChip(
              label: Text(isDistanceLoading ? 'جاري تحديد موقعك...' : option.label),
              selected: _sortOption == option,
              onSelected: _isLocating
                  ? null
                  : (selected) {
                      if (selected) _selectSortOption(option);
                    },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<HerafiModel> results) {
    return Column(
      children: [
        _buildSortChips(),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final herafi = results[index];

              return ListTile(
                onTap: () => _openHerafi(herafi),
                leading: ClipOval(
                  child: CustomImageLoading(
                    imageUrl: herafi.imageUrl,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(herafi.name),
                subtitle: Text(herafi.jobTitle.join(' & ')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentHistory() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'آخر الحرفيين اللي زرتهم',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: widget.onClearHistory,
                child: const Text('مسح'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: widget.recentHerafis.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final herafi = widget.recentHerafis[index];

              return ListTile(
                onTap: () => _openHerafi(herafi),
                leading: ClipOval(
                  child: CustomImageLoading(
                    imageUrl: herafi.imageUrl,
                    width: 48,
                    height: 48,
                  ),
                ),
                title: Text(herafi.name),
                subtitle: Text(herafi.jobTitle.join(' & ')),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryState() {
    if (widget.historyLoadFailed) {
      return const Center(child: Text('تعذر تحميل سجل البحث'));
    }

    if (widget.isHistoryLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.recentHerafis.isEmpty) {
      return const Center(
        child: Text(
          'ابدأ بالبحث عن الحرفيين',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return _buildRecentHistory();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSucess) {
          return Expanded(child: _buildSearchResults(state.searchResults));
        }

        if (state is SearchFailure) {
          return Expanded(
            child: Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        return Expanded(child: _buildHistoryState());
      },
    );
  }
}