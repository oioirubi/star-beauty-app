import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_beauty_app/screens/usuario/login_screen.dart';
import 'package:star_beauty_app/screens/usuario/user_home.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      return UserHome(
        userId: currentUser.uid,
        userType: 'defaultType',
        title: '',
        description: '',
        categories: const [],
      );
    } else {
      return const LoginScreen();
    }
  }
}
