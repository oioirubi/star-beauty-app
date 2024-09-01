import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/user_home.dart';
import 'screens/training_videos.dart';
import 'screens/entertainment.dart';
import 'screens/search_screen.dart';
import 'screens/swot_analysis_screen.dart';
import 'screens/objectives_panel.dart';
import 'screens/monthly_report_screen.dart';
import 'screens/action_plan_screen.dart';
import 'screens/business_model_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/user': (context) => UserHome(
              userType: 'user',
              userId: '',
            ), // Ajuste conforme necessário
        '/swot_analysis': (context) => SWOTAnalysisScreen(),
        '/objectives_panel': (context) => ObjectivesPanel(),
        '/monthly_report': (context) => MonthlyReportScreen(
              userType: '',
            ),
        '/action_plan': (context) => ActionPlanScreen(
              userType: '',
            ),
        '/business_model': (context) => BusinessModelScreen(
              userType: '',
            ),
        // Adicione outras rotas conforme necessário
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
                    userType: args['userType']!, userId: args['userId']!);
              },
            );
          } else {}
        }
        return null;
      },
    );
  }
}
