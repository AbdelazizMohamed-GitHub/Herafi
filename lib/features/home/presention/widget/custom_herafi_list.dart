import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/core/loading/custom_home_loading.dart';
import 'package:herafi_app/core/widget/custom_error_widget.dart';
import 'package:herafi_app/core/widget/custom_loading_widget.dart';
import 'package:herafi_app/features/home/presention/cubits/home_cubit/home_cubit.dart';
import 'package:herafi_app/features/home/presention/cubits/home_cubit/home_state.dart';
import 'package:herafi_app/features/home/presention/widget/custom_herafi_item_widget.dart';

class CustomHerafiList extends StatelessWidget {
  const CustomHerafiList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state is GetHomeDataLoading
            ? CustomHomeLoadingWidget()
            : state is HomeError
            ? CustomErrorWidget(
                errorMessage: state.failure.message,
                onRetry: () => context.read<HomeCubit>().getHomeData(),
              )
            : state is HomeLoaded
            ? state.herafiList.isNotEmpty
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: state.herafiList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(thickness: 0.8);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return CustomHerafiItemWidget(
                          herafi: state.herafiList[index],
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              'لا يوجد حرفيين في هذا التصنيف',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )
            : SizedBox();
      },
    );
  }
}
