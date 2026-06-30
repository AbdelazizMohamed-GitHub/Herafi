import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/funcation/funcation.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_drop_down_form_field_widget.dart';
import 'package:herafi_app/core/widget/custom_otp_widget.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_cubit.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_state.dart';

class CustomSignUpBodyWidget extends StatefulWidget {
  const CustomSignUpBodyWidget({super.key});

  @override
  State<CustomSignUpBodyWidget> createState() => _CustomSignUpBodyWidgetState();
}

class _CustomSignUpBodyWidgetState extends State<CustomSignUpBodyWidget> {
  bool otpSent = false;
  bool verified = false;

  final phoneController = TextEditingController();
  final nameController = TextEditingController();

  String? selectedJob;
  String otp = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAME
          const Text('الاسم ثلاثي', style: HerafiStyles.text20Black),
          const SizedBox(height: 8),

          CustomTextForm(
            textController: nameController,
            pIcon: Icons.person,
            text: 'ادخل اسمك',
            kType: TextInputType.name,
          ),

          const SizedBox(height: 16),

          /// JOB
          const Text('نوع الحرفة', style: HerafiStyles.text20Black),
          const SizedBox(height: 8),

          CustomDropdownFormField(
            onChanged: (value) {
              selectedJob = value;
            },
          ),

          const SizedBox(height: 16),

          /// PHONE + SEND OTP
          const Text('رقم الهاتف', style: HerafiStyles.text20Black),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: CustomTextForm(
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
                            if (_formKey.currentState!.validate() &&
                                phoneRegex.hasMatch(phoneController.text)) {
                              String phone = formatEgyptPhone(
                                phoneController.text,
                              );
                              await context.read<AuthCubit>().sendOtp(phone);
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

          /// OTP
          CustomOtpWidget(
            otpSent: otpSent,
            onChanged: (value) {
              otp = value;
            },
            onCompleted: (value) async {
              otp = value;

              await context.read<AuthCubit>().verifyOtp(value).then((_) {});
            },
          ),

          const SizedBox(height: 16),

          /// CREATE ACCOUNT
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is OtpSent) {
                setState(() {
                  otpSent = true;
                });
              } else if (state is VerifyOtpLoading) {
                CustomSnackBarWidget.show(
                  context,
                  type: SnackBarType.warning,
                  message: 'جاري التحقق من الكود',
                );
              } else if (state is OtpVerified) {
                verified = true;

                CustomSnackBarWidget.show(
                  context,
                  message: 'تم التحقق بنجاح',
                  type: SnackBarType.success,
                );
              } else if (state is AuthError) {
                CustomSnackBarWidget.show(
                  type: SnackBarType.error,
                  context,
                  message: state.massageFailure,
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await context.read<AuthCubit>().createAccount(
                      name: nameController.text,
                      job: selectedJob ?? '',
                      phoneNumber: phoneController.text,
                    );
                  }
                },
                text: state is CreateAccountLoading
                    ? 'جاري التحميل'
                    : 'إنشاء حساب',
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
