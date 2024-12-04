import 'package:flutter/material.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key, required String userType, required String userId});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Bem-vindo ao Starflix!'),
    );
  }
}
