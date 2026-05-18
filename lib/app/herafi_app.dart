import 'package:flutter/material.dart';
import 'package:herafi_app/app/router/router.dart';

class HerafiApp extends StatelessWidget {
  const HerafiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: herafiRouter,
      debugShowCheckedModeBanner: false,
      title: 'حـرفـي',
    );
  }
}
