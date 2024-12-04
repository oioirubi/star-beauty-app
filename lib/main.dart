import 'package:star_beauty_app/app_router.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase inicializado com sucesso!");
  } catch (e) {
    print("Erro ao inicializar Firebase: $e");
  }
  runApp(const StarBeautyApp());
}

class StarBeautyApp extends StatelessWidget {
  const StarBeautyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Star Beauty',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
    );
  }
}
