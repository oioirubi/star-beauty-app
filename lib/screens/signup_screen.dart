import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = '';
  String password = '';
  String userType = 'professional'; // Valor padrão para 'professional'

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void registerUser() async {
    try {
      // Cria uma nova conta no Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Salva o usuário no Firestore com o tipo de usuário (Profissional ou Proprietário)
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'userType': userType, // Salva se é 'professional' ou 'owner'
      });

      // Redireciona para a área do usuário após o registro
      Navigator.pushNamed(context, '/user', arguments: {
        'userType': userType,
        'userId': userCredential.user!.uid,
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      if (e.code == 'weak-password') {
        errorMessage = 'A senha é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Esse email já está cadastrado.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'O email fornecido é inválido.';
      } else {
        errorMessage = 'Erro ao registrar. Tente novamente.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao registrar. Tente novamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
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
              onPressed: registerUser,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
