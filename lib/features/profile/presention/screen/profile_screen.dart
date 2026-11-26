import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_error_widget.dart';
import 'package:herafi_app/core/widget/custom_loading_widget.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_cubit.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_state.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_herafi_data_widget.dart';
import 'package:herafi_app/features/profile/presention/widget/add_review_bottom_sheet.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_detail_tile.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_profile_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.herafi});
  final HerafiModel? herafi;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool get isCurrentUser => widget.herafi == null;

  void _openReviewSheet(String herafiId) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      CustomSnackBarWidget.show(
        context,
        message: 'سجّل الدخول لإضافة تقييم',
        type: SnackBarType.warning,
        onTap: () {
          context.push(HerafiRoutes.signIn);
        },
        textButton: 'تسجيل الدخول',
      );
      return;
    }
    if (currentUser.uid == herafiId) {
      CustomSnackBarWidget.show(
        context,
        message: 'لا يمكنك تقييم ملفك الشخصي',
        type: SnackBarType.warning,
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddReviewBottomSheet(herafiId: herafiId),
    );
  }

  @override
  void initState() {
    super.initState();
    if (isCurrentUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<ProfileCubit>().getHerafiData();
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<ProfileCubit>().getHerafiById(
            herafiId: widget.herafi!.id,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 25,
            ),
          ),
          title: const Text('الملف الشخصي'),
        ),
        body: !isCurrentUser
            ? BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return CustomHerafiDataWidget(
                      herafi: state.herafi,
                      hasReviewed: state.hasReviewed,
                      onAddReview: state.hasReviewed
                          ? null
                          : () => _openReviewSheet(state.herafi.id),
                    );
                  }
                  if (state is ProfileError) {
                    return CustomErrorWidget(
                      errorMessage: state.failure.message,
                      onRetry: () => context.read<ProfileCubit>().getHerafiById(
                        herafiId: widget.herafi!.id,
                      ),
                    );
                  }
                  return const Center(child: CustomLoadingWidget());
                },
              )
            : BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is GetProfileDataLoading) {
                    return const Center(child: CustomLoadingWidget());
                  }
                  if (state is ProfileError) {
                    return CustomErrorWidget(
                      errorMessage: state.failure.message,
                      onRetry: () =>
                          context.read<ProfileCubit>().getHerafiData(),
                    );
                  }
                  if (state is ProfileLoaded) {
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              CustomProfileHeaderWidget(herafi: state.herafi),
                              const SizedBox(height: 16),
                              CustomProfileDetailTileWidget(
                                icon: Icons.phone,
                                label: 'رقم الهاتف',
                                value: state.herafi.phoneNumber,
                                ontap: () {},
                              ),
                              CustomProfileDetailTileWidget(
                                icon: Icons.location_on,
                                label: 'الموقع',
                                value:
                                    state.herafi.location?.trim().isNotEmpty ==
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
                                      onPressed: () {
                                        context.push(
                                          HerafiRoutes.editProfile,
                                          extra: state.herafi,
                                        );
                                      },
                                      text: 'تعديل الملف الشخصي',
                                      color: HerafiColors.darkBlueColor,
                                      textStyle: HerafiStyles.text20White,
                                    ),
                                    const SizedBox(height: 20),
                                    CustomButton(
                                      onPressed: () async {
                                        await context
                                            .read<ProfileCubit>()
                                            .userLogout();
                                        if (context.mounted) {
                                          context.go(HerafiRoutes.welcome);
                                        }
                                      },
                                      text: 'تسجيل الخروج',
                                      color: HerafiColors.goldColor,
                                      textStyle: HerafiStyles.text20Black,
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
      ),
    );
  }
}
