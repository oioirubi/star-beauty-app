import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String userType = 'professional'; // Valor padrão para 'professional'

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    try {
      print('Tentando fazer login com: $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(
          'Login realizado com sucesso para usuário: ${userCredential.user!.uid}');

      // Redireciona para a área do usuário após o login
      Navigator.pushNamed(context, '/user', arguments: {
        'userType': userType,
        'userId': userCredential.user!.uid,
      });
    } on FirebaseAuthException catch (e) {
      print('Erro no login: ${e.code}');
      String errorMessage = '';

      if (e.code == 'wrong-password') {
        errorMessage = 'Senha incorreta.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'Usuário não encontrado.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {
        errorMessage = 'Erro ao fazer login. Tente novamente.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print('Erro desconhecido: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao fazer login. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            // Escolha do Tipo de Usuário (Profissional ou Proprietário)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Profissional'),
                  selected: userType == 'professional',
                  onSelected: (selected) {
                    setState(() {
                      userType = 'professional';
                    });
                  },
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Proprietário'),
                  selected: userType == 'owner',
                  onSelected: (selected) {
                    setState(() {
                      userType = 'owner';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loginUser,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
