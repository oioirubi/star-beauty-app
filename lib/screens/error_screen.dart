import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final String userType;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 24, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => context.go('/'), // Volta para a rota inicial
              child: const Text('Voltar para o início'),
            ),
          ],
        ),
      ),
    );
  }
}
