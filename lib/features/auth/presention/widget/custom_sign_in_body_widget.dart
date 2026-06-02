import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomSignInBodyWidget extends StatelessWidget {
  const CustomSignInBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text('رقم الهاتف أو البريد', style: HerafiStyles.text20Black),

        const SizedBox(height: 10),

        CustomTextForm(
          pIcon: Icons.email,
          text: 'ادخل رقم الهاتف',
          kType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 20),

        MaterialPinField(
          length: 6,
          // onCompleted: (pin) => print('PIN: $pin'),
          // onChanged: (value) => print('Changed: $value'),
          theme: MaterialPinTheme(
            shape: MaterialPinShape.outlined,
            cellSize: Size(56, 64),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 20),

        CustomButton(
          onPressed: () {
            context.push(HerafiRoutes.home);
          },
          text: 'تسجيل الدخول',
          color: HerafiColors.goldColor,
          textStyle: HerafiStyles.text26boldDarkBlue,
        ),
      ],
    );
  }
}
