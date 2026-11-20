import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/core/constant/herfa_list.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/features/home/data/repo_impl/search_repo_impl.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(searchRepo: SearchRepoImpl()),
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
                  CustomSearchResultList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
