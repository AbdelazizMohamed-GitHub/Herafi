import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_cubit.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpWidget extends StatefulWidget {
  final bool otpSent;
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  const CustomOtpWidget({
    super.key,
    required this.otpSent,
    this.onChanged,
    this.onCompleted,
  });

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

        /// OTP FIELD
        AbsorbPointer(
          absorbing: !widget.otpSent,
          child: Opacity(
            opacity: widget.otpSent ? 1 : 0.4,
            child: MaterialPinField(
              length: 6,

              onChanged: (value) {
                setState(() {
                  otp = value;
                });

                widget.onChanged?.call(value);
              },

              onCompleted: (value) {
                setState(() {
                  otp = value;
                });

                widget.onCompleted?.call(value);
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
