import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpWidget extends StatefulWidget {
  const CustomOtpWidget({super.key});

  @override
  State<CustomOtpWidget> createState() => _CustomOtpWidgetState();
}

class _CustomOtpWidgetState extends State<CustomOtpWidget> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: AlignmentGeometry.topRight,
          child: const Text('كود التحقق', style: HerafiStyles.text20Black),
        ),

        const SizedBox(height: 12),

        MaterialPinField(
          length: 6,
          onChanged: (value) {
            setState(() {
              otp = value;
            });
          },
          onCompleted: (value) {
            otp = value;
          },
          theme: MaterialPinTheme(
            shape: MaterialPinShape.outlined,
            cellSize: const Size(52, 60),
            borderRadius: BorderRadius.circular(12),

            borderWidth: 1,

            elevation: 2,
          ),
        ),

        const SizedBox(height: 20),

        /// زر التأكيد
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: otp.length == 6
                  ? HerafiColors.darkBlueColor
                  : Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: otp.length == 6
                ? () {
                    print("OTP = $otp");
                    // هنا Firebase verify
                  }
                : null,
            child: Text(
              'تأكيد الكود',
              style: HerafiStyles.text20Black.copyWith(
                color: otp.length == 6 ? Colors.white : Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
