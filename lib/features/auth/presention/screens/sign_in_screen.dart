import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/routes.dart';
import 'package:herafi_app/app/theme/app_colors.dart';
import 'package:herafi_app/app/theme/app_style.dart';
import 'package:herafi_app/core/constant/assets/app_image.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';
import 'package:herafi_app/features/auth/presention/widget/auth_appbar_widget.dart';
import 'package:herafi_app/features/auth/presention/widget/custom_google_facebook_auth_widget.dart';
import 'package:herafi_app/features/auth/presention/widget/custom_sign_in_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HerafiColors.background,
      body: CustomScrollView(
        slivers: [
          //AuthAppBarWidget
          AuthAppBarWidget(appbarTitle: 'سجل دخولك في '),

          // Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomSignInWidget
                  CustomSignInWidget(),

                  const SizedBox(height: 25),

                  const Center(
                    child: Text('أو', style: HerafiStyles.text26boldDarkBlue),
                  ),

                  const SizedBox(height: 25),

                  //CustomGoolge&FaceBookAuthWidget
                  CustomGoogleFacebookAuthWidget(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('مش عندك حساب؟ ', style: HerafiStyles.text20Black),
                      TextButton(
                        onPressed: () {
                          context.go(HerafiRoutes.signUp);
                        },
                        child: Text(
                          ' سجل الآن',
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
