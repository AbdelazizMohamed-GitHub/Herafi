import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/core/widget/custom_drop_down_form_field_widget.dart';
import 'package:herafi_app/core/widget/custom_otp_widget.dart';
import 'package:herafi_app/core/widget/custom_snakbar_widget.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_cubit.dart';
import 'package:herafi_app/features/auth/presention/cubits/auth_state.dart';
import 'package:herafi_app/features/auth/presention/widget/custom_phone_otp_widget.dart';

class CustomSignUpBodyWidget extends StatefulWidget {
  const CustomSignUpBodyWidget({super.key});

  @override
  State<CustomSignUpBodyWidget> createState() => _CustomSignUpBodyWidgetState();
}

class _CustomSignUpBodyWidgetState extends State<CustomSignUpBodyWidget> {
  bool otpSent = false;
  bool verified = false;

  final nameController = TextEditingController();

  String? selectedJob;
  String otp = '';
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';

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
          CustomPhoneOtpWidget(

            formKey: _formKey,
            phoneChanged: (val) {
              phoneNumber = val;
            },
          ),
          CustomOtpWidget(
            otpSent: otpSent,

            onCompleted: (value) async {
              await context.read<AuthCubit>().verifyOtp(value);
            },
          ),
          const SizedBox(height: 16),

          /// CREATE ACCOUNT
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                CustomSnackBarWidget.show(
                  context,
                  message: state.failure.message,
                  type: SnackBarType.error,
                );
              }
              if (state is OtpSent) {
                setState(() {
                  otpSent = true;
                });
              } else if (state is VerifyOtpLoading) {
                customSnackbarloadingwidget(
                  context: context,
                  message: 'جارٍ التحقق من الكود...',
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
                  message: state.failure.message,
                );
              } else if (state is CreateAccountSuccess) {
                context.push(HerafiRoutes.home);
              }
            },
            builder: (context, state) {
              return CustomButton(
                onPressed: verified
                    ? () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<AuthCubit>().createAccount(
                            name: nameController.text,
                            job: selectedJob ?? '',
                            phoneNumber: phoneNumber,
                          );
                        }
                      }
                    : () {
                        CustomSnackBarWidget.show(
                          type: SnackBarType.error,
                          context,
                          message: 'يجب التحقق من الكود اولا',
                        );
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
