import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_otp_widget.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class CustomSignInBodyWidget extends StatefulWidget {
  const CustomSignInBodyWidget({super.key});

  @override
  State<CustomSignInBodyWidget> createState() => _CustomSignInBodyWidgetState();
}

class _CustomSignInBodyWidgetState extends State<CustomSignInBodyWidget> {
  bool otpSent = false;
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text('رقم الهاتف أو البريد', style: HerafiStyles.text20Black),

        const SizedBox(height: 10),

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
              child: const Text('إرسال', style: HerafiStyles.text16BlackBold),
            ),
          ],
        ),

        const SizedBox(height: 16),

        CustomOtpWidget(otpSent: otpSent),
        const SizedBox(height: 20),

        CustomButton(
          onPressed: verified
              ? () {
                  // create account
                }
              : () {
                  CustomSnackBarWidget.show(
                    context,
                    message: 'يجب عليك تحقق من الكود أولاً',
                    type: SnackBarType.warning,
                  );
                },
          text: 'تسجيل الدخول',
          color: HerafiColors.goldColor,
          textStyle: HerafiStyles.text20White,
        ),
      ],
    );
  }
}
