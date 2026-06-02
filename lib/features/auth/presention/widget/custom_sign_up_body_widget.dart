import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_drop_down_form_field_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomSignUpBodyWidget extends StatefulWidget {
  const CustomSignUpBodyWidget({super.key});

  @override
  State<CustomSignUpBodyWidget> createState() => _CustomSignUpBodyWidgetState();
}

class _CustomSignUpBodyWidgetState extends State<CustomSignUpBodyWidget> {
  bool showOtp = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Name
        const Text('الاسم ثلاثي', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        CustomTextForm(
          pIcon: Icons.person,
          text: 'ادخل اسمك',
          kType: TextInputType.name,
        ),

        const SizedBox(height: 16),

        /// Phone
        const Text('رقم الهاتف', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        CustomTextForm(
          pIcon: Icons.phone,
          text: '+20xxxxxxxxxx',
          kType: TextInputType.phone,
        ),

        const SizedBox(height: 16),

        /// Job
        const Text('نوع الحرفة', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        CustomDropdownFormField(),

        const SizedBox(height: 24),

        /// OTP يظهر بعد الإرسال
        if (showOtp) ...[
          const Text('كود التحقق', style: HerafiStyles.text20Black),

          const SizedBox(height: 12),

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
        ],

        /// Button
        CustomButton(
          onPressed: () {
            if (!showOtp) {
              // send otp
              setState(() {
                showOtp = true;
              });
            } else {
              // verify otp
            }
          },
          text: showOtp ? 'تأكيد الكود' : 'إرسال كود التحقق',
          color: HerafiColors.goldColor,
          textStyle: HerafiStyles.text26boldDarkBlue,
        ),
      ],
    );
  }
}
