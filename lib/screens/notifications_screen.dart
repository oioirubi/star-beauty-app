import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class NotificationsScreen extends StatelessWidget {
  final String userType;
  final String userId;

  const NotificationsScreen(
      {super.key, required this.userType, required this.userId});

  void _addSampleNotification(BuildContext context) {
    FirestoreService().addNotification(userId, {
      'title': 'Nova Notificação',
      'message': 'Esta é uma mensagem de teste',
      'timestamp': FieldValue.serverTimestamp(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notificação de teste adicionada')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar notificação: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addSampleNotification(context),
        tooltip: 'Adicionar Notificação de Teste',
        child: const Icon(Icons.add),
      ),
    );
  }
}
