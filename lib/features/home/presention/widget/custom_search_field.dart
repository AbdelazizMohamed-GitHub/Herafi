import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.onQueryChanged});

  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 8,
        top: 16,
        bottom: 16,
      ),
      decoration: const BoxDecoration(
        color: HerafiColors.darkBlueColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          Expanded(
            child: CustomTextForm(
              onChanged: onQueryChanged,
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
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}