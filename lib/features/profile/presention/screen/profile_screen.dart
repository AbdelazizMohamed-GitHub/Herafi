import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/services/user_service.dart';
import 'package:herafi_app/core/widget/custom_error_widget.dart';
import 'package:herafi_app/core/widget/custom_loading_widget.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/profile/data/repo_impl/pofile_repo_impl.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_cubit.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_state.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_herafi_data_widget.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_detail_tile.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_header_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.herafi});
  final HerafiModel? herafi;
  bool get isCurrentUser => herafi == null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        lazy: false,
        create: (context) {
          final profileCubit = ProfileCubit(
            profileRepo: ProfileRepoImpl(userService: UserService()),
          );
          if (isCurrentUser) {
            profileCubit.getHerafiData();
          }
          return profileCubit;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
            ),
            title: Text('الملف الشخصي'),
          ),
          body: !isCurrentUser
              ? CustomHerafiDataWidget(herafi: herafi!)
              : BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return state is GetProfileDataLoading
                            ? Center(child: CustomLoadingWidget())
                            : state is ProfileError
                            ? CustomErrorWidget(
                                errorMessage: state.failure.message,
                                onRetry: () => context
                                    .read<ProfileCubit>()
                                    .getHerafiData(),
                              )
                            : state is ProfileLoaded
                            ? CustomScrollView(
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: Column(
                                      children: [
                                        CustomProfileHeaderWidget(
                                          herafi: isCurrentUser
                                              ? state.herafi
                                              : herafi!,
                                        ),
                                        const SizedBox(height: 28),

                                        CustomProfileDetailTileWidget(
                                          icon: Icons.phone,
                                          label: 'رقم الهاتف',
                                          value: state.herafi.phoneNumber,
                                          ontap: () {},
                                        ),

                                        const SizedBox(height: 16),

                                        CustomProfileDetailTileWidget(
                                          icon: Icons.location_on,
                                          label: 'الموقع',
                                          value:
                                              state.herafi.location
                                                      ?.trim()
                                                      .isNotEmpty ==
                                                  true
                                              ? state.herafi.location!
                                              : 'لا يوجد عنوان',

                                          ontap: () {},
                                        ),
                                        const SizedBox(height: 32),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                          child: Column(
                                            children: [
                                              CustomButton(
                                                onPressed: () async {
                                                  final result = await context
                                                      .push(
                                                        HerafiRoutes
                                                            .editProfile,
                                                        extra: state.herafi,
                                                      );
                                                },
                                                text: "تعديل الملف الشخصي",
                                                color:
                                                    HerafiColors.darkBlueColor,
                                                textStyle:
                                                    HerafiStyles.text20White,
                                              ),
                                              SizedBox(height: 20),
                                              CustomButton(
                                                onPressed: () async {
                                                  await context
                                                      .read<ProfileCubit>()
                                                      .userLogout();
                                                  if (context.mounted) {
                                                    context.go(
                                                      HerafiRoutes.welcome,
                                                    );
                                                  }
                                                },
                                                text: "تسجيل الخروج",
                                                color: HerafiColors.goldColor,
                                                textStyle:
                                                    HerafiStyles.text20Black,
                                              ),
                                              SizedBox(height: 12),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink();
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
