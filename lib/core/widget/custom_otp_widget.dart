import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpWidget extends StatelessWidget {
  final bool otpSent;
  final Function(String)? onCompleted;

  const CustomOtpWidget({super.key, required this.otpSent, this.onCompleted});

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

        /// OTP FIELD
        AbsorbPointer(
          absorbing: !otpSent,
          child: Opacity(
            opacity: otpSent ? 1 : 0.4,
            child: MaterialPinField(
              length: 6,

              onCompleted: (value) {
                onCompleted?.call(value);
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

        /// VERIFY BUTTON
      ],
    );
  }
}
