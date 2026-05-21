import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/app_colors.dart';
import 'package:herafi_app/app/theme/app_style.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class CustomSignInBodyWidget extends StatelessWidget {
  const CustomSignInBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('رقم الهاتف أو البريد', style: HerafiStyles.text20Black),

        const SizedBox(height: 10),

        CustomTextForm(
          pIcon: Icons.email,
          text: 'ادخل رقم الهاتف او البريد',
          kType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('كلمة المرور', style: HerafiStyles.text20Black),
            Text(
              'نسيت كلمة المرور؟',
              style: TextStyle(
                color: Color(0xffF5A623),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        CustomTextForm(text: 'ادخل كلمة المرور', kType: TextInputType.text),
        const SizedBox(height: 20),

        CustomButton(
          onPressed: () {},
          text: 'تسجيل الدخول',
          color: HerafiColors.goldColor,
          textStyle: HerafiStyles.text26boldDarkBlue,
        ),
      ],
    );
  }
}
