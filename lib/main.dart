import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:star_beauty_app/app_router.dart';
import 'package:star_beauty_app/global_state/firebase_auth_notifier.dart';
import 'firebase_options.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FirebaseAuthNotifier(),
        ),
      ],
      child: const StarBeautyApp(),
    ),
  );
}

class StarBeautyApp extends StatelessWidget {
  const StarBeautyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Move a criação do router para este ponto
    final router = createRouter(context);

    return MaterialApp.router(
      title: 'Star Beauty App',
      routerConfig: router,
    );
  }
}
