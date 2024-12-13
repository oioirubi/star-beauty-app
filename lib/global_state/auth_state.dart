import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = true; // Adiciona uma variável para rastrear o carregamento

  AuthState() {
    _initializeAuthState();
  }

  // Getter para o estado de carregamento
  bool get isLoading => _isLoading;

  // Getter para o usuário atual
  User? get currentUser => _currentUser;

  // Inicializa o estado de autenticação
  Future<void> _initializeAuthState() async {
    _isLoading = true; // Inicia o estado como carregando
    notifyListeners();

    try {
      _currentUser = FirebaseAuth.instance.currentUser;
    } finally {
      _isLoading = false; // Conclui o carregamento
      notifyListeners();
    }
  }

  // Método para logout
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Método para login (adapte conforme necessário)
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      _currentUser = userCredential.user;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
