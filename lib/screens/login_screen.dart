import 'package:flutter/material.dart';
import '../global_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nome de Usuário'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                GlobalState.userName = _controller.text;
                GlobalState.userPhotoUrl =
                    null; // Adicione um URL para foto se necessário
                Navigator.pushNamed(context, '/user', arguments: {
                  'userType':
                      'user', // Substitua pelo tipo correto se necessário
                  'userId': 'userId', // Substitua pelo ID correto se necessário
                });
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
