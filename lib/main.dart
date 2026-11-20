import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herafi_app/app/herafi_app.dart';
import 'package:herafi_app/app/utils/app_keys.dart';
import 'package:herafi_app/firebase_options.dart';
import 'package:herafi_app/observer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  await Supabase.initialize(
    url: AppKeys.supbaseUrl,
    publishableKey: AppKeys.supbaseApiKey,
  );
  runApp(const HerafiApp());
}
