import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:star_beauty_app/components/custom_container.dart';
import 'package:star_beauty_app/global_classes/firebase_user_utils.dart';
import 'package:star_beauty_app/themes/app_themes.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //User local informations
  UserData currentUser = UserData(type: "professional");
  bool _isWaitingVerification = false;
  Function()?
      onUserRegistered; //for a user to be registered we consider that he is verified to

  //Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //on user verification concluded
    _auth.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        currentUser.uid = user.uid;
        FirebaseUserUtils().registerUser(currentUser, onSuccessfull: () {
          //confirmação na tela
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text("Dados do usuário salvos no Firestore com sucesso.")),
          );
          //e envia o usuário para a próxima página
          context.go('/user_home', extra: {
            'userType': currentUser.type,
            'userId': currentUser.uid,
          });
        });
      }
    });
  }

  // Método para registrar o usuário
  void tryRegisterUser(UserData newUser) async {
    if (!_formKey.currentState!.validate()) {
      debugPrint("Formulário inválido.");
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      debugPrint("Tentando criar usuário com email: ${newUser.email}");

      // Cria o usuário no Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: newUser.email.trim(),
        password: newUser.password,
      );

      if (userCredential.user == null) {
        throw Exception("Erro ao criar usuário no Firebase Authentication.");
      }

      await userCredential.user?.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email de verificação enviado!')),
      );

      _isWaitingVerification = true;
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 435.0),
          child: CustomContainer(
            title: 'Star Beauty',
            child: _isWaitingVerification
                ? const Text("Por favor, verifique seu email")
                : _buildWidgetForm(),
          ),
        ),
      ),
    );
  }

  Form _buildWidgetForm() {
    return Form(
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
            onChanged: (value) => currentUser.email = value,
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
            onChanged: (value) => currentUser.password = value,
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
            validator: (value) {
              if (value != currentUser.password) {
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
                selected: currentUser.type == 'professional',
                selectedColor: roxo,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: currentUser.type == 'professional'
                      ? Colors.white
                      : Colors.black,
                ),
                onSelected: (selected) {
                  setState(() {
                    currentUser.type = 'professional';
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Eu sou Proprietário'),
                selected: currentUser.type == 'owner',
                selectedColor: roxo,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color:
                      currentUser.type == 'owner' ? Colors.white : Colors.black,
                ),
                onSelected: (selected) {
                  setState(() {
                    currentUser.type = 'owner';
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 22),
          ElevatedButton(
            onPressed: _isLoading
                ? null
                : () {
                    tryRegisterUser(currentUser);
                  },
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
    );
  }
}

class UserData {
  //Register variables
  String uid;
  String email;
  String password;
  String type; // Valor padrão para 'professional'

  UserData(
      {this.uid = '', this.email = '', this.password = '', this.type = ''});
}
