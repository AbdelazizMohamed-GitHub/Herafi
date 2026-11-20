import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/funcation/funcation.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_cubit.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_state.dart';

class CustomPhoneOtpWidget extends StatefulWidget {
  const CustomPhoneOtpWidget({
    super.key,
    required this.formKey,
    this.phoneChanged,
  });
  final GlobalKey<FormState> formKey;
  final Function(String)? phoneChanged;

  @override
  State<CustomPhoneOtpWidget> createState() => _CustomPhoneOtpWidgetState();
}

class _CustomPhoneOtpWidgetState extends State<CustomPhoneOtpWidget> {
  final phoneController = TextEditingController();

  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('رقم الهاتف', style: HerafiStyles.text20Black),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: CustomTextForm(
                enabled: !otpSent,
                textController: phoneController,
                pIcon: Icons.phone,
                text: 'رقـم الهاتف',
                kType: TextInputType.phone,
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final isCooldown = state is OtpResendCooldown;

                final seconds = isCooldown ? state.seconds : 0;

                return TextButton(
                  onPressed: isCooldown
                      ? null
                      : () async {
                          if (widget.formKey.currentState!.validate() &&
                              HerafiFunctions.phoneRegex.hasMatch(
                                phoneController.text,
                              )) {
                            String phone = HerafiFunctions.formatEgyptPhone(
                              phoneController.text,
                            );
                            await context.read<AuthCubit>().sendOtp(phone);
                            setState(() {
                              widget.phoneChanged?.call(phoneController.text);
                              otpSent = true;
                            });
                          } else {
                            CustomSnackBarWidget.show(
                              type: SnackBarType.warning,
                              context,
                              message: 'يرجي كتابة رقم الهاتف صحيح',
                            );
                          }
                        },
                  child: Text(
                    isCooldown
                        ? 'إعادة الإرسال بعد \n$seconds ثانية'
                        : 'إرسال الكود',
                    textAlign: TextAlign.center,
                    style: HerafiStyles.text16BlackBold.copyWith(
                      color: isCooldown ? Colors.grey : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ],
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
