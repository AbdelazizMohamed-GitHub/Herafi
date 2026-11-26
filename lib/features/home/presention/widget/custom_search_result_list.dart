import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/core/loading/custom_image_loading.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_state.dart';

class CustomSearchResultList extends StatelessWidget {
  const CustomSearchResultList({
    super.key,
    required this.recentHerafis,
    required this.isHistoryLoading,
    required this.historyLoadFailed,
    required this.onClearHistory,
  });

  final List<HerafiModel> recentHerafis;
  final bool isHistoryLoading;
  final bool historyLoadFailed;
  final VoidCallback onClearHistory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return state is SearchSucess
            ? Expanded(
                child: ListView.builder(
                  itemCount: state.searchResults.length,
                  itemBuilder: (context, index) {
                    final herafi = state.searchResults[index];
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.push(HerafiRoutes.profile, extra: herafi);
                      },
                      child: ListTile(
                        leading: ClipOval(
                          child: CustomImageLoading(
                            imageUrl: herafi.imageUrl,
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: Text(herafi.name),
                        subtitle: Text(herafi.jobTitle.toList().join(' & ')),
                      ),
                    );
                  },
                ),
              )
            : state is SearchFailure
            ? Center(
                child: Text(state.errorMessage, style: TextStyle(fontSize: 16)),
              )
            : Expanded(
                child: historyLoadFailed
                    ? const Center(child: Text('تعذر تحميل سجل البحث'))
                    : isHistoryLoading
                    ? const Center(child: CircularProgressIndicator())
                    : recentHerafis.isEmpty
                    ? const Center(
                        child: Text(
                          'ابدأ بالبحث عن الحرفيين',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    'آخر الحرفيين اللي زرتهم',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: onClearHistory,
                                  child: const Text('مسح'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: recentHerafis.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 4),
                              itemBuilder: (context, index) {
                                final herafi = recentHerafis[index];
                                return ListTile(
                                  leading: ClipOval(
                                    child: CustomImageLoading(
                                      imageUrl: herafi.imageUrl,
                                      width: 48,
                                      height: 48,
                                    ),
                                  ),
                                  title: Text(herafi.name),
                                  subtitle: Text(herafi.jobTitle.join(' & ')),
                                  onTap: () {
                                    context.push(
                                      HerafiRoutes.profile,
                                      extra: herafi,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
      },
    );
  }
}
