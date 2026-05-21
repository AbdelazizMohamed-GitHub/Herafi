import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/app_colors.dart';
import 'package:herafi_app/app/theme/app_style.dart';
import 'package:herafi_app/core/constant/assets/app_image.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HerafiColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: HerafiColors.darkBlueColor,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
            ),
            expandedHeight: 280,
            pinned: true,

            // يظهر بعد الـ scroll
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'سجل دخولك في',
                      style: HerafiStyles.text26boldWhite,
                    ),
                    TextSpan(text: ' حرفي', style: HerafiStyles.text26boldGold),
                  ],
                ),
              ),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(HerafiImage.logoLight, width: 250, height: 250),
                ],
              ),
            ),
          ),

          // Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'رقم الهاتف أو البريد',
                    style: HerafiStyles.text20Black,
                  ),

                  const SizedBox(height: 10),

                  CustomTextForm(
                    pIcon: Icons.email,
                    text: 'ادخل رقم الهاتف او البريد',
                    kType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('كلمة المرور', style: HerafiStyles.text20Black),
                      Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyle(
                          color: Color(0xffF5A623),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  CustomTextForm(
                    text: 'ادخل كلمة المرور',
                    kType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),

                  CustomButton(
                    onPressed: () {},
                    text: 'تسجيل الدخول',
                    color: HerafiColors.goldColor,
                    textStyle: HerafiStyles.text26boldDarkBlue,
                  ),

                  const SizedBox(height: 25),

                  const Center(
                    child: Text('أو', style: HerafiStyles.text26boldDarkBlue),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 0.3, color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(HerafiImage.facebook),
                              Text('  فيسبوك', style: HerafiStyles.text20Black),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 0.3, color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(HerafiImage.google),
                              Text('  جوجل', style: HerafiStyles.text20Black),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('مش عندك حساب؟ ', style: HerafiStyles.text20Black),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          ' سجل الآن',
                          style: HerafiStyles.text20Gold.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
