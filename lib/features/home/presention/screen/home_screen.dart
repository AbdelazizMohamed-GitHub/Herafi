import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/constant/assets/herafi_image.dart';
import 'package:herafi_app/core/services/herfa_service.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/features/home/data/repo_impl/home_repo_impl.dart';
import 'package:herafi_app/features/home/presention/cubits/home_cubit/home_cubit.dart';
import 'package:herafi_app/features/home/presention/cubits/home_cubit/home_state.dart';
import 'package:herafi_app/features/home/presention/screen/search_screen.dart';
import 'package:herafi_app/features/home/presention/widget/custom_category_list.dart';
import 'package:herafi_app/features/home/presention/widget/custom_herafi_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(homeRepo: HomeRepoImpl(herfaService: HerfaService()))
            ..getHomeData(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    context.push(
                      HerafiRoutes.search,
                      extra: context.read<HomeCubit>().allHerafiList,
                    );
                  },
                  icon: Icon(Icons.search),
                );
              },
            ),
            SizedBox(width: 12),
            FirebaseAuth.instance.currentUser == null
                ? SizedBox()
                : GestureDetector(
                    onTap: () => context.push(HerafiRoutes.profile),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(HerafiImage.emptyUserPicture),
                    ),
                  ),
            const SizedBox(width: 12),
          ],
          title: Text("الرئيسية"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<HomeCubit>().getHomeData();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 8),
                  child: Text('التصنيفات', style: HerafiStyles.text20Black),
                ),
          
                SizedBox(height: 80, child: CustomCategoryList()),
          
                Divider(thickness: 1, color: Colors.black),
                CustomHerafiList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
