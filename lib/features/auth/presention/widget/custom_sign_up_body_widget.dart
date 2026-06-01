import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_drop_down_form_field_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class CustomSignUpBodyWidget extends StatelessWidget {
  const CustomSignUpBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text('الاسم ثلاثي', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        CustomTextForm(
          pIcon: Icons.person,
          text: 'ادخل اسمك ',
          kType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),

        const Text('رقم الهاتف أو البريد', style: HerafiStyles.text20Black),

        const SizedBox(height: 8),

        CustomTextForm(
          pIcon: Icons.email,
          text: 'ادخل رقم الهاتف او البريد',
          kType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 12),
        Text('كلمة المرور', style: HerafiStyles.text20Black),

        const SizedBox(height: 8),

        CustomTextForm(
          text: 'ادخل كلمة المرور',
          kType: TextInputType.text,
          pIcon: Icons.lock,
          obscureText: true,
        ),
        const SizedBox(height: 12),

        CustomTextForm(
          text: 'ادخل كلمة المرور مره اخري ',
          kType: TextInputType.text,
          pIcon: Icons.lock,
          obscureText: true,
        ),
        SizedBox(height: 12),
        CustomDropdownFormField(),

        const SizedBox(height: 20),

        CustomButton(
          onPressed: () {
            context.push(HerafiRoutes.home);
          },
          text: 'ءانشاء حساب',
          color: HerafiColors.goldColor,
          textStyle: HerafiStyles.text26boldDarkBlue,
        ),
      ],
    );
  }
}
