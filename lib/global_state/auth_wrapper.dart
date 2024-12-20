import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:star_beauty_app/screens/usuario/login_screen.dart';
import 'package:star_beauty_app/screens/usuario/user_home.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<Map<String, dynamic>?> loadUserData(String userId) async {
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    return userData.data();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return FutureBuilder<Map<String, dynamic>?>(
        future: loadUserData(currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
                child: Text("Erro ao carregar dados do usuário"));
          }

          return const UserHome();
        },
      );
    } else {
      return const LoginScreen();
    }
  }
}
