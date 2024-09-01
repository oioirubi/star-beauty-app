import 'package:flutter/material.dart';

class Entertainment extends StatelessWidget {
  final String userType;

  const Entertainment({super.key, required this.userType});

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
