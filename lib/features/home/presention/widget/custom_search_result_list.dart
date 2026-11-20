import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/core/loading/custom_image_loading.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_cubit.dart';
import 'package:herafi_app/features/home/presention/cubits/search_cubit.dart/search_state.dart';

class CustomSearchResultList extends StatelessWidget {
  const CustomSearchResultList({super.key});

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
            : Center(
                child: Text(
                  'ابدأ بالبحث عن الحرفيين',
                  style: TextStyle(fontSize: 16),
                ),
              );
      },
    );
  }
}
