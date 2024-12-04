import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/themes/app_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

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
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 435.0, // Limite de largura para o formulário
            minHeight: 0.0, // Altura mínima necessária para caber tudo
          ),
          child: CustomContainer(
            title: 'Star Beauty', // Título no topo do container
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Mantém o tamanho do conteúdo
              children: [
                const Text(
                  'Cadastro',
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
                const SizedBox(height: 8),

                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirmação da Senha',
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
                const SizedBox(height: 8),

                // Escolha do Tipo de Usuário (Profissional ou Proprietário)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChoiceChip(
                      label: const Text(' Eu sou Profissional '),
                      selected: userType == 'professional',
                      selectedColor: Colors.black38,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: userType == 'professional'
                            ? Colors.white
                            : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          userType = 'professional';
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text(' Eu sou Proprietário '),
                      selected: userType == 'owner',
                      selectedColor: Colors.black38,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color:
                            userType == 'owner' ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          userType = 'owner';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                // Botões Criar Conta e Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botão Criar Conta
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
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
                        'Já tenho uma Conta',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Botão Login
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
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
                        'Cadastrar',
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
