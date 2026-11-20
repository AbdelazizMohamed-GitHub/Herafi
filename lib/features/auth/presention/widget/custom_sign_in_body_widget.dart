import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_otp_widget.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_cubit.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_state.dart';
import 'package:herafi_app/features/auth/presention/widget/custom_phone_otp_widget.dart';

class CustomSignInBodyWidget extends StatefulWidget {
  const CustomSignInBodyWidget({super.key});

  @override
  State<CustomSignInBodyWidget> createState() => _CustomSignInBodyWidgetState();
}

class _CustomSignInBodyWidgetState extends State<CustomSignInBodyWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String phoneNumber = '';

  bool otpSent = false;
  bool verified = false;
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const SizedBox(height: 16),

          CustomPhoneOtpWidget(
            formKey: _formKey,
            phoneChanged: (val) {
              phoneNumber = val;
            },
          ),
          CustomOtpWidget(
            otpSent: otpSent,

            onCompleted: (value) async {
              otp = value;

              // No verification logic here, just a placeholder for OTP completion
            },
          ),
          const SizedBox(height: 16),

          const SizedBox(height: 20),

          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                CustomSnackBarWidget.show(
                  context,
                  message: state.failure.message,
                  type: SnackBarType.error,
                );
              } else if (state is OtpSent) {
                setState(() {
                  otpSent = true;
                });
              } else if (state is OtpVerified) {
                verified = true;
                context.push(HerafiRoutes.home);
              } else if (state is VerifyOtpLoading) {
                customSnackbarloadingwidget(
                  context: context,
                  message: 'جارٍ التحقق من كود التحقق...',
                );
              } else if (state is OtpResendCooldown) {
                // يمكنك تحديث واجهة المستخدم هنا إذا كنت تريد عرض العد التنازلي
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () async {
                  otpSent
                      ? await context.read<AuthCubit>().verifyOtp(otp)
                      : CustomSnackBarWidget.show(
                          type: SnackBarType.warning,
                          context,
                          message: 'يرجي ارسال كود التحقق',
                        );
                },
                text: 'تسجيل الدخول',
                color: HerafiColors.goldColor,
                textStyle: HerafiStyles.text20White,
              );
            },
          ),
        ],
      ),
    );
  }
}
