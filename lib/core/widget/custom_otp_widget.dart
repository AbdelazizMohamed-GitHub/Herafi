import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpWidget extends StatefulWidget {
  final bool otpSent;

  const CustomOtpWidget({super.key, required this.otpSent});

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
        const Align(
          alignment: Alignment.topRight,
          child: Text('كود التحقق', style: HerafiStyles.text20Black),
        ),

        const SizedBox(height: 12),

        /// 🔥 OTP ALWAYS VISIBLE
        AbsorbPointer(
          absorbing: !widget.otpSent, // يمنع الكتابة
          child: Opacity(
            opacity: widget.otpSent ? 1 : 0.4, // شكل مقفول بصريًا
            child: MaterialPinField(
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
          ),
        ),

        const SizedBox(height: 20),

        /// زر التأكيد
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: (otp.length == 6 && widget.otpSent)
                  ? HerafiColors.darkBlueColor
                  : Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: (otp.length == 6 && widget.otpSent)
                ? () {
                    print("OTP = $otp");
                    // Firebase verify
                  }
                : null,
            child: Text(
              'تأكيد الكود',
              style: HerafiStyles.text20Black.copyWith(
                color: (otp.length == 6 && widget.otpSent)
                    ? Colors.white
                    : Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
