import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_drop_down_form_field_widget.dart';
import 'package:herafi_app/core/widget/custom_otp_widget.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class CustomSignUpBodyWidget extends StatefulWidget {
  const CustomSignUpBodyWidget({super.key});

  @override
  State<CustomSignUpBodyWidget> createState() => _CustomSignUpBodyWidgetState();
}

class _CustomSignUpBodyWidgetState extends State<CustomSignUpBodyWidget> {
  bool otpSent = false;
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// NAME
        const Text('الاسم ثلاثي', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        CustomTextForm(
          pIcon: Icons.person,
          text: 'ادخل اسمك',
          kType: TextInputType.name,
        ),

        const SizedBox(height: 16),

        /// JOB
        const Text('نوع الحرفة', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        CustomDropdownFormField(),

        const SizedBox(height: 16),

        /// PHONE + SEND OTP
        const Text('رقم الهاتف', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: CustomTextForm(
                pIcon: Icons.phone,
                text: '+20xxxxxxxxxx',
                kType: TextInputType.phone,
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  otpSent = true;
                });

                // send OTP here
              },
              child: const Text('إرسال'),
            ),
          ],
        ),

        const SizedBox(height: 16),

        /// OTP (ONLY AFTER SEND)
        CustomOtpWidget(),

        const SizedBox(height: 16),

        /// CREATE ACCOUNT (AFTER VERIFY ONLY)
        CustomButton(
          onPressed: verified
              ? () {
                  // create account
                }
              : () {
                  CustomSnackBarWidget.showWarning(
                    context,
                    message: 'يجب عليك تحقق من الكود أولاً',
                  );
                },
          text: 'إنشاء حساب',
          color: HerafiColors.goldColor,
          textStyle: HerafiStyles.text20White,
        ),
      ],
    );
  }
}
