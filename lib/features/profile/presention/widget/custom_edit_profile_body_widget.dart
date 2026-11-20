import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/model/herafi_model.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        CustomTextForm(
          enabled: editMode,
          text: 'تعديل الاسم',
          kType: TextInputType.text,
          pIcon: Icons.person,
          textController: nameController,
        ),
        SizedBox(height: 16),
        CustomTextForm(
          enabled: editMode,
          text: 'تعديل الرقم',
          kType: TextInputType.text,
          pIcon: Icons.phone,
          textController: phoneController,
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
          kType: TextInputType.name,
          pIcon: Icons.location_on,
          textController: locationController,
        ),
        SizedBox(height: 16),
        BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileError) {
              print('Error is ${state.failure.message}');
              CustomSnackBarWidget.show(
                context,
                message: state.failure.message,
                type: SnackBarType.error,
              );
            } else if (state is UpdateProfileDataLoading) {
              customSnackbarloadingwidget(
                context: context,
                message: 'جارٍ حفظ التعديلات...',
              );
            } else if (state is ProfileLoaded) {
              context.pop(true); // إغلاق الشاشة والعودة إلى الشاشة السابقة
            }
          },
          builder: (context, state) {
            return CustomButton(
              onPressed: () async {
                final updatedHerafi = widget.herafi.copyWith(
                  id: widget.herafi.id,
                  name: nameController.text,
                  phoneNumber: phoneController.text,
                  location: locationController.text,
                  jobTitle: [
                    selectedJob1 ?? widget.herafi.jobTitle.first,
                    if (selectedJob2 != null)
                      selectedJob2 ?? widget.herafi.jobTitle.last,
                  ],
                  imageUrl: widget.herafi.imageUrl,
                );
                setState(() {
                  editMode = false; // بعد الحفظ، قم بتعطيل التعديل
                });
                await context.read<ProfileCubit>().updateProfileData(
                  herafi: updatedHerafi,
                  selectedImage: widget.selectedImage,
                );
              },
              text: "حفظ التعديلات",
              color: HerafiColors.goldColor,
              textStyle: HerafiStyles.text20White,
            );
          },
        ),
      ],
    );
  }
}
