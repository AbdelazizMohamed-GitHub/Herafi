import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/hearfi_routes.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/features/auth/presention/widget/auth_appbar_widget.dart';
import 'package:herafi_app/features/auth/presention/widget/custom_google_facebook_auth_widget.dart';
import 'package:herafi_app/features/auth/presention/widget/custom_sign_up_body_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AuthAppBarWidget(appbarTitle: 'انشئ حسابك في '),

          // Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //CustomSignUpBodyWidget
                  CustomSignUpBodyWidget(),

                  const SizedBox(height: 25),

                  const Center(
                    child: Text('أو', style: HerafiStyles.text26boldDarkBlue),
                  ),

                  const SizedBox(height: 25),

                  CustomGoogleFacebookAuthWidget(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('لو عندك حساب؟ ', style: HerafiStyles.text20Black),
                      TextButton(
                        onPressed: () {
                          context.push(HerafiRoutes.signIn);
                        },
                        child: Text(
                          'سجل الدخول ',
                          style: HerafiStyles.text20Gold.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
