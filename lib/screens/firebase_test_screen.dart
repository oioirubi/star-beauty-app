import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTestScreen extends StatelessWidget {
  const FirebaseTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseFirestore.instance
                  .collection('test')
                  .add({'test': 'data'});
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Firebase is connected!')));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to connect to Firebase')));
            }
          },
          child: const Text('Test Firebase Connection'),
        ),
      ),
    );
  }
}
