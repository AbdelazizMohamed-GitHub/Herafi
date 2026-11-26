import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/di/service_locator.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';
import 'package:herafi_app/core/services/recent_herafi_service.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/home/presention/widget/custom_category_search_item.dart';
import 'package:herafi_app/features/home/presention/widget/custom_search_result_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.herafiList});
  final List<HerafiModel> herafiList;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int cureenIndex = 0;
  String query = '';
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
        setState(() {
          _historyLoadFailed = true;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isHistoryLoading = false;
        });
      }
    }
  }

  Future<void> _clearRecentHistory() async {
    try {
      await _recentHerafiService.clear();
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تعذر مسح سجل البحث')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 8,
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      color: HerafiColors.darkBlueColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                        Expanded(
                          child: CustomTextForm(
                            onChanged: (value) {
                              setState(() {
                                query = value;
                              });
                              if (value.trim().isEmpty && cureenIndex == 0) {
                                context.read<SearchCubit>().clearSearch();
                                return;
                              }
                              context.read<SearchCubit>().searchHerafi(
                                query: value,
                                allHerafiList: widget.herafiList,
                                selectedCategory:
                                    herfaList[cureenIndex].herfaName,
                              );
                            },
                            text: 'ابحث عن حرفي',
                            kType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء إدخال نص للبحث';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CustomCategorySearchItem(
                            index: index,
                            funcation: () {
                              setState(() {
                                cureenIndex = index;
                              });
                              if (query.trim().isEmpty && index == 0) {
                                context.read<SearchCubit>().clearSearch();
                                return;
                              }
                              context.read<SearchCubit>().searchHerafi(
                                query: query,
                                allHerafiList: widget.herafiList,
                                selectedCategory: herfaList[index].herfaName,
                              );
                            },
                            currentIndex: cureenIndex,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8),
                        itemCount: herfaList.length,
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
