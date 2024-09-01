import 'package:flutter/material.dart';
import '../global_state.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome de Usuário'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Simular o cadastro do usuário
                GlobalState.userName = _nameController.text;
                GlobalState.userPhotoUrl =
                    null; // Pode ser adicionado um URL para foto se necessário
                Navigator.pushNamed(context, '/user', arguments: {
                  'userType':
                      'user', // Substitua pelo tipo correto se necessário
                  'userId': 'userId', // Substitua pelo ID correto se necessário
                });
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
