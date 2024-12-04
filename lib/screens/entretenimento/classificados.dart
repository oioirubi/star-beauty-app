import 'package:flutter/material.dart';

class Classificados extends StatelessWidget {
  final String userType;

  const Classificados({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entretenimento'),
      ),
      body: Center(
        child: Text(userType == 'professional'
            ? 'Conteúdo de Entretenimento para Profissionais'
            : 'Conteúdo de Entretenimento para Proprietários'),
      ),
    );
  }
}
