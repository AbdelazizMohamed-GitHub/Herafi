import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/di/service_locator.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';
import 'package:herafi_app/core/services/recent_herafi_service.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/home/presention/widget/custom_category_search_item.dart';
import 'package:herafi_app/features/home/presention/widget/custom_search_result_list.dart';
import 'package:herafi_app/features/home/presention/widget/custom_search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.herafiList});

  final List<HerafiModel> herafiList;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _currentIndex = 0;
  String _query = '';
  late final RecentHerafiService _recentHerafiService;
  bool _isHistoryLoading = true;
  bool _historyLoadFailed = false;

  @override
  void initState() {
    super.initState();
    _recentHerafiService = getIt<RecentHerafiService>();
    _loadRecentHistory();
  }

  Future<void> _loadRecentHistory() async {
    try {
      await _recentHerafiService.load();
    } on Exception {
      if (mounted) {
        setState(() => _historyLoadFailed = true);
      }
    } finally {
      if (mounted) {
        setState(() => _isHistoryLoading = false);
      }
    }
  }

  Future<void> _clearRecentHistory() async {
    try {
      await _recentHerafiService.clear();
    } on Exception {
      if (mounted) {
        CustomSnackBarWidget.showToast(message: 'تعذر مسح سجل البحث');
       
      }
    }
  }

  void _onHerafiSelected(HerafiModel herafi) {
    unawaited(_recentHerafiService.record(herafi.id));
  }

  void _search(SearchCubit cubit, String query, int categoryIndex) {
    if (query.trim().isEmpty && categoryIndex == 0) {
      cubit.clearSearch();
      return;
    }

    cubit.searchHerafi(
      query: query,
      allHerafiList: widget.herafiList,
      selectedCategory: herfaList[categoryIndex].herfaName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchCubit>(),
      child: Builder(
        builder: (context) {
          final searchCubit = context.read<SearchCubit>();

          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  CustomSearchField(
                    onQueryChanged: (value) {
                      setState(() => _query = value);
                      _search(searchCubit, value, _currentIndex);
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: herfaList.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          return CustomCategorySearchItem(
                            index: index,
                            currentIndex: _currentIndex,
                            funcation: () {
                              setState(() => _currentIndex = index);
                              _search(searchCubit, _query, index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _recentHerafiService,
                    builder: (context, _) {
                      final herafisById = {
                        for (final herafi in widget.herafiList)
                          herafi.id: herafi,
                      };

                      final recentHerafis = _recentHerafiService.recentHerafiIds
                          .map((id) => herafisById[id])
                          .whereType<HerafiModel>()
                          .toList();

                      return CustomSearchResultList(
                        recentHerafis: recentHerafis,
                        isHistoryLoading: _isHistoryLoading,
                        historyLoadFailed: _historyLoadFailed,
                        onClearHistory: _clearRecentHistory,
                        onHerafiSelected: _onHerafiSelected,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
