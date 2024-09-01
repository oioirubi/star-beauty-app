import 'package:flutter/material.dart';
import '../main.dart'; // Certifique-se de importar corretamente

class HomeScreen extends StatelessWidget {
  final String userId = 'test-user-id';

  const HomeScreen({super.key}); // Substitua pelo ID real do usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(),
    );
  }
}
