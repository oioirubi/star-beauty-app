import 'package:flutter/material.dart';
import 'base_screen.dart';

class BusinessModelScreen extends StatelessWidget {
  final String userType;

  const BusinessModelScreen({Key? key, required this.userType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userType: userType,
      userId: 'userId', // Passe o userId correto aqui
      child: Center(
        child: Text(
          'Tela de Modelo de Negócio',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
