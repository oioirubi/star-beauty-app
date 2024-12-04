import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400.0, // Limite de largura para o formulário
          ),
          child: CustomContainer(
            title: 'Star Beauty', // Título no topo do container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Mantém o tamanho do conteúdo
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.grey[100], // Fundo suave para o campo
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[300]!, // Borda sempre visível
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            roxo.withOpacity(0.7), // Borda em destaque ao focar
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    filled: true,
                    fillColor: Colors.grey[100], // Fundo suave para o campo
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[300]!, // Borda sempre visível
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            roxo.withOpacity(0.7), // Borda em destaque ao focar
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 22),

                // Botões Criar Conta e Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão Criar Conta
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0, // Altura do botão
                          horizontal: 24.0, // Largura do botão
                        ),
                        minimumSize:
                            const Size(150, 50), // Tamanho mínimo (opcional)
                        foregroundColor: roxo, // Cor do texto
                        backgroundColor: Colors.grey[200], // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100.0), // Borda arredondada
                        ),
                      ),
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Botão Login
                    ElevatedButton(
                      onPressed: loginUser,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0, // Altura do botão
                          horizontal: 24.0, // Largura do botão
                        ),
                        minimumSize:
                            const Size(150, 50), // Tamanho mínimo (opcional)
                        foregroundColor: Colors.white, // Cor do texto
                        backgroundColor: roxo, // Cor de fundo
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(100.0), // Borda arredondada
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
