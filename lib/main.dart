import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:star_beauty_app/screens/signup_screen.dart';
import 'dart:io';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/user_home.dart';
import 'screens/swot_analysis_screen.dart';
import 'screens/objectives_panel.dart';
import 'screens/monthly_report_screen.dart';
import 'screens/action_plan_screen.dart';
import 'screens/business_model_screen.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

//Inicialização do Firebase
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
  runApp(StarBeautyApp());
}

Future<void> uploadFile(String filePath) async {
  File file = File(filePath);

  try {
    await FirebaseStorage.instance.ref('uploads/file-name.jpg').putFile(file);
  } on FirebaseException catch (e) {
    print('Erro ao fazer upload: $e');
  }
}

class StarBeautyApp extends StatelessWidget {
  const StarBeautyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Beauty',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/swot_analysis': (context) => const SWOTAnalysisScreen(),
        '/objectives_panel': (context) => const ObjectivesPanel(
              userType: '',
            ),
        '/monthly_report': (context) => const MonthlyReportScreen(
              userType: '',
            ),
        '/action_plan': (context) => const ActionPlanScreen(
              userType: '',
            ),
        '/business_model': (context) => const BusinessModelScreen(
              userType: '',
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/user') {
          final args = settings.arguments as Map<String, String>?;
          if (args != null &&
              args.containsKey('userType') &&
              args.containsKey('userId')) {
            return MaterialPageRoute(
              builder: (context) {
                return UserHome(
                  userType: args['userType']!,
                  userId: args['userId']!,
                );
              },
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => const ErrorScreen(
                message: 'Argumentos inválidos para a rota /user',
              ),
            );
          }
        }
        return null;
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const ErrorScreen(
          message: 'Rota desconhecida',
        ),
      ),
    );
  }
}

// ErrorScreen class implementation (para evitar erros e debugar melhor)
class ErrorScreen extends StatelessWidget {
  final String message;
  const ErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Erro'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
