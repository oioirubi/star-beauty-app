import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_beauty_app/global_state/auth_state.dart';
import 'package:star_beauty_app/screens/usuario/login_screen.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);

    if (authState.currentUser == null) {
      // Se não estiver logado, redirecione para a página de login
      return const LoginScreen();
    }

    // Caso contrário, renderize a página protegida
    return child;
  }
}
