import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/app/utils/app_validate.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_cubit.dart';
import 'package:herafi_app/features/profile/presention/cubit/profile_state.dart';
import 'package:herafi_app/features/profile/presention/widget/custom_job_widget.dart';

class CustomEditProfileBodyWidget extends StatefulWidget {
  const CustomEditProfileBodyWidget({
    super.key,
    required this.herafi,
    required this.selectedImage,
  });
  final HerafiModel herafi;
  final Uint8List? selectedImage;
  @override
  State<CustomEditProfileBodyWidget> createState() =>
      _CustomEditProfileBodyWidgetState();
}

class _CustomEditProfileBodyWidgetState
    extends State<CustomEditProfileBodyWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.herafi.name;
    phoneController.text = widget.herafi.phoneNumber;
    locationController.text = widget.herafi.location ?? '';
    selectedJob1 = widget.herafi.jobTitle.first;
    selectedJob2 = widget.herafi.jobTitle.length > 1
        ? widget.herafi.jobTitle.last
        : null;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedJob1;
  String? selectedJob2;
  bool editMode = true; // حالة التعديل، افتراضيًا true

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          CustomTextForm(
            enabled: editMode,
            text: 'تعديل الاسم',
            kType: TextInputType.name,
            pIcon: Icons.person,
            textController: nameController,
            validator: AppValidate.name,
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            enabled: editMode,
            text: 'تعديل الرقم',
            kType: TextInputType.phone,
            pIcon: Icons.phone,
            textController: phoneController,
            validator: AppValidate.phone,
          ),

          // Job Title Dropdowns
          CustomJobWidget(
            selectedJob1: selectedJob1,
            selectedJob2: selectedJob2,
            onJob1Changed: (value) {
              setState(() {
                selectedJob1 = value;
              });
            },
            onJob2Changed: (value) {
              setState(() {
                selectedJob2 = value;
              });
            },
          ),

          CustomTextForm(
            enabled: editMode,
            text: 'تعديل الموقع',
            kType: TextInputType.streetAddress,
            pIcon: Icons.location_on,
            textController: locationController,
            validator: AppValidate.location,
            sIcon: IconButton(
              onPressed: editMode
                  ? () {
                      // فتح الخريطة واختيار الموقع
                    }
                  : null,
              icon: const Icon(Icons.map_outlined),
              tooltip: 'اختيار الموقع من الخريطة',
            ),
          ),
          const SizedBox(height: 16),
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
                setState(() {
                  editMode = true;
                });
                CustomSnackBarWidget.show(
                  context,
                  message: state.failure.message,
                  type: SnackBarType.error,
                );
              } else if (state is UpdateProfileDataLoading) {
                setState(() {
                  editMode = false;
                });
                customSnackbarloadingwidget(
                  context: context,
                  message: 'جارٍ حفظ التعديلات...',
                );
              } else if (state is ProfileLoaded) {
                context.pop(true); // إغلاق الشاشة والعودة إلى الشاشة السابقة
              }
            },
            builder: (context, state) {
              final isLoading = state is UpdateProfileDataLoading;
              return CustomButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        if (selectedJob1 == null ||
                            selectedJob1!.trim().isEmpty) {
                          CustomSnackBarWidget.show(
                            context,
                            message: 'الرجاء اختيار الحرفة الأولى',
                            type: SnackBarType.error,
                          );
                          return;
                        }
                        if (selectedJob2 != null &&
                            selectedJob2 == selectedJob1) {
                          CustomSnackBarWidget.show(
                            context,
                            message: 'يجب أن تكون الحرفتان مختلفتين',
                            type: SnackBarType.error,
                          );
                          return;
                        }

                        final updatedHerafi = widget.herafi.copyWith(
                          id: widget.herafi.id,
                          name: nameController.text.trim(),
                          phoneNumber: phoneController.text.trim(),
                          location: locationController.text.trim(),
                          jobTitle: [
                            selectedJob1!,
                            if (selectedJob2 != null &&
                                selectedJob2!.trim().isNotEmpty)
                              selectedJob2!,
                          ],
                          imageUrl: widget.herafi.imageUrl,
                        );
                        await context.read<ProfileCubit>().updateProfileData(
                          herafi: updatedHerafi,
                          selectedImage: widget.selectedImage,
                        );
                      },
                text: isLoading ? "جارٍ الحفظ..." : "حفظ التعديلات",
                color: HerafiColors.goldColor,
                textStyle: HerafiStyles.text20White,
              );
            },
          ),
        ],
      ),
    );
  }
}
