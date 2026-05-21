import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:herafi_app/app/router/routes.dart';
import 'package:herafi_app/app/theme/app_colors.dart';
import 'package:herafi_app/app/theme/app_style.dart';
import 'package:herafi_app/core/constant/assets/app_image.dart';
import 'package:herafi_app/core/widget/custom_text_form.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              expandedTitleScale: 1,
              centerTitle: true,
              title: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'انشئ حسابك في ',
                      style: HerafiStyles.text26boldWhite,
                    ),
                    TextSpan(
                      text: ' حِرفي',
                      style: HerafiStyles.text26boldGold,
                    ),
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
                  const Text('الاسم ثلاثي', style: HerafiStyles.text20Black),
                  const SizedBox(height: 8),

                  CustomTextForm(
                    pIcon: Icons.person,
                    text: 'ادخل اسمك ',
                    kType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'رقم الهاتف أو البريد',
                    style: HerafiStyles.text20Black,
                  ),

                  const SizedBox(height: 8),

                  CustomTextForm(
                    pIcon: Icons.email,
                    text: 'ادخل رقم الهاتف او البريد',
                    kType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 12),
                  Text('كلمة المرور', style: HerafiStyles.text20Black),

                  const SizedBox(height: 8),

                  CustomTextForm(
                    text: 'ادخل كلمة المرور',
                    kType: TextInputType.text,
                    pIcon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),

                  CustomTextForm(
                    text: 'ادخل كلمة المرور مره اخري ',
                    kType: TextInputType.text,
                    pIcon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,

                      hint: Text('اختر حرفتك'),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    items: [
                      DropdownMenuItem(
                        value: 'سيراميك',
                        child: const Text('سيراميك'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),

                  const SizedBox(height: 20),

                  CustomButton(
                    onPressed: () {},
                    text: 'ءانشاء حساب',
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
                          height: 50,
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('لو عندك حساب؟ ', style: HerafiStyles.text20Black),
                      TextButton(
                        onPressed: () {
                          context.go(HerafiRoutes.signIn);
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
