import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String userType = 'professional'; // Valor padrão para 'professional'
  bool hasSelectedUserType = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Método para registrar o usuário
  void registerUser() async {
    if (!_formKey.currentState!.validate()) {
      debugPrint("Formulário inválido.");
      return;
    }

    if (!hasSelectedUserType) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecione o tipo de usuário!')),
      );
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      debugPrint("Tentando criar usuário com email: $email");

      // Cria o usuário no Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception("Erro ao criar usuário no Firebase Authentication.");
      }

      debugPrint("Usuário criado com UID: ${user.uid}");

      // Adiciona os campos ao Firestore
      await _firestore.collection('users').doc(user.uid).set({
        "email": email.trim(),
        "name": "",
        "adress": "",
        "profilePicture": "",
        "starBeautyStars": 0,
        "userType": userType,
        "title": "",
        "bio": "",
        "location": "",
        "language": "Português",
        "createdAt": FieldValue.serverTimestamp(),
        "lastLogin": FieldValue.serverTimestamp(),
        // Novos campos do perfil profissional
        "areaOfExpertise": "",
        "experienceTime": "",
        "potentialDescription": "",
        "professionalExperience": "",
        "completedCourses": "",
        "incomeExpectation": "",
      });

      debugPrint("Dados do usuário salvos no Firestore com sucesso.");

      // Redireciona para a página de perfil do usuário
      context.go('/user_home', extra: {
        'userType': userType,
        'userId': user.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário registrado com sucesso!')),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("Erro do FirebaseAuth: ${e.code}");

      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'A senha é muito fraca.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Esse email já está cadastrado.';
          break;
        case 'invalid-email':
          errorMessage = 'O email fornecido é inválido.';
          break;
        default:
          errorMessage = 'Erro ao registrar. Tente novamente.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      debugPrint("Erro geral ao registrar: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao registrar. Tente novamente.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> deleteCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete(); // Exclui o usuário do Firebase Authentication
        print("Usuário excluído com sucesso.");
      } else {
        print("Nenhum usuário autenticado para excluir.");
      }
    } on FirebaseAuthException catch (e) {
      print("Erro ao excluir usuário: ${e.message}");
      if (e.code == 'requires-recent-login') {
        print("É necessário fazer login novamente antes de excluir o usuário.");
      }
    } catch (e) {
      print("Erro desconhecido ao excluir o usuário: $e");
    }
  }

  Future<void> reauthenticateAndDeleteUser(
      String email, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("Nenhum usuário autenticado.");
        return;
      }

      // Reautentica o usuário
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Exclui o usuário após a reautenticação
      await user.delete();
      print("Usuário reautenticado e excluído com sucesso.");
    } on FirebaseAuthException catch (e) {
      print("Erro ao reautenticar/excluir usuário: ${e.message}");
    } catch (e) {
      print("Erro desconhecido: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 435.0),
          child: CustomContainer(
            title: 'Star Beauty',
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cadastro',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onChanged: (value) => email = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um email.';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Insira um email válido.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: roxo.withOpacity(0.7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) => password = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha.';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: roxo.withOpacity(0.7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    onChanged: (value) => confirmPassword = value,
                    validator: (value) {
                      if (value != password) {
                        return 'As senhas não coincidem.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirme sua senha',
                      filled: true,
                      fillColor: Colors.grey[100],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: roxo.withOpacity(0.7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChoiceChip(
                        label: const Text('Eu sou Profissional'),
                        selected: userType == 'professional',
                        selectedColor: roxo,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color: userType == 'professional'
                              ? Colors.white
                              : Colors.black,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            userType = 'professional';
                            hasSelectedUserType = true;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('Eu sou Proprietário'),
                        selected: userType == 'owner',
                        selectedColor: roxo,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(
                          color:
                              userType == 'owner' ? Colors.white : Colors.black,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            userType = 'owner';
                            hasSelectedUserType = true;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: _isLoading ? null : registerUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      minimumSize: const Size(150, 50),
                      foregroundColor: Colors.white,
                      backgroundColor: roxo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Cadastrar',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
