import 'package:flutter/material.dart';
import 'package:herafi_app/app/router/herafi_router.dart';
import 'package:herafi_app/app/theme/herafi_colors.dart';
import 'package:herafi_app/app/theme/herafi_style.dart';
import 'package:herafi_app/app/theme/herafi_theme.dart';

class HerafiApp extends StatelessWidget {
  const HerafiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: HerafiTheme.lightTheme,

      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      routerConfig: herafiRouter,
      debugShowCheckedModeBanner: false,
      title: 'حـرفـي',
    );
  }
}
