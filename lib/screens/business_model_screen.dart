import 'package:flutter/material.dart';
import '../components/base_screen.dart';

class BusinessModelScreen extends StatelessWidget {
  final String userType;

  const BusinessModelScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userType: userType,
      userId: 'userId', // Passe o userId correto aqui
      child: const Center(
        child: Text(
          'Tela de Modelo de Negócio',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
