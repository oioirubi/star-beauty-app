import 'package:flutter/material.dart';
import '../components/base_screen.dart';

class UserHome extends StatelessWidget {
  final String userType; // 'professional' ou 'owner'
  final String userId; // ID do usuário atual

  const UserHome({super.key, required this.userType, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      userType: userType,
      userId: userId, // Passe o userId correto aqui
      child: Center(
        child: Text(
          userType == 'professional'
              ? 'Bem-vindo ao Ambiente do Profissional'
              : 'Bem-vindo ao Ambiente do Proprietário',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
