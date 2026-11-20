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

        BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              current is OtpSent || current is OtpResendReady,
          listener: (context, state) {
            setState(() {
              otpSent = state is OtpSent;
            });

            if (state is OtpSent) {
              widget.phoneChanged?.call(phoneController.text);
            }
          },
          child: Row(
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
              BlocSelector<AuthCubit, AuthState, (bool, int)>(
                selector: (state) {
                  final cubit = context.read<AuthCubit>();
                  return (cubit.isResendActive, cubit.resendSeconds);
                },
                builder: (context, cooldown) {
                  final (isCooldown, seconds) = cooldown;

                  return TextButton(
                    onPressed: isCooldown
                        ? null
                        : () async {
                            final isFormValid = widget.formKey.currentState!
                                .validate();
                            final isPhoneValid = HerafiFunctions.phoneRegex
                                .hasMatch(phoneController.text);

                            if (!isFormValid || !isPhoneValid) {
                              CustomSnackBarWidget.show(
                                type: SnackBarType.warning,
                                context,
                                message: 'يرجي كتابة رقم الهاتف صحيح',
                              );
                              return;
                            }

                            final phone = HerafiFunctions.formatEgyptPhone(
                              phoneController.text,
                            );

                            await context.read<AuthCubit>().sendOtp(phone);
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
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
