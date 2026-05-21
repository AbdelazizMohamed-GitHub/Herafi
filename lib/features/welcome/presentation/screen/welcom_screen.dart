import 'package:flutter/material.dart';
import 'package:herafi_app/app/theme/app_colors.dart';
import 'package:herafi_app/app/theme/app_style.dart';
import 'package:herafi_app/core/widget/cutom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HerafiColors.background,
      appBar: AppBar(
        backgroundColor: HerafiColors.darkBlueColor,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'حِـ', style: HerafiStyles.text26boldWhite),
              TextSpan(text: 'ـرفـي', style: HerafiStyles.text26boldGold),
            ],
          ),
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'مرحبا بك في ',
                              style: HerafiStyles.text26boldDarkBlue,
                            ),
                            TextSpan(
                              text: 'حِــرفـي',
                              style: HerafiStyles.text26boldGold,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'أختر نوع حسابك للمتابعة',
                        style: HerafiStyles.text20Black,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "أنا عـمـيـل",
                              style: HerafiStyles.text26boldDarkBlue,
                            ),
                            trailing: Icon(
                              Icons.person_outlined,
                              size: 30,
                              color: HerafiColors.goldColor,
                            ),
                          ),
                          Text(
                            'ابحث عن حرفيين موثقيين للمهام المنزلية',
                            style: HerafiStyles.text20Black,
                          ),
                          SizedBox(height: 12),
                          CustomButton(
                            onPressed: () {},
                            text: 'اخـتـر كـعـمـيل',
                            color: HerafiColors.darkBlueColor,
                            textStyle: HerafiStyles.text26boldWhite,
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "أنا حـرفي",
                              style: HerafiStyles.text26boldDarkBlue,
                            ),
                            trailing: Icon(
                              Icons.handyman_outlined,
                              size: 30,
                              color: HerafiColors.goldColor,
                            ),
                          ),
                          Text(
                            'ابحث عن حرفيين موثقيين للمهام المنزلية',
                            style: HerafiStyles.text20Black,
                          ),
                          SizedBox(height: 12),
                          CustomButton(
                            onPressed: () {},
                            text: 'اخـتـر كـحـرفي',
                            color: HerafiColors.goldColor,
                            textStyle: HerafiStyles.text26boldDarkBlue,
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('هل لديك حساب ؟', style: HerafiStyles.text20Black),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'تسجيل الدخول',
                          style: HerafiStyles.text20Gold.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
