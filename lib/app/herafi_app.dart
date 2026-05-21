import 'package:flutter/material.dart';
import 'package:herafi_app/app/router/herafi_router.dart';

class HerafiApp extends StatelessWidget {
  const HerafiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      routerConfig: herafiRouter,
      debugShowCheckedModeBanner: false,

      title: 'حـرفـي',
    );
  }
}
