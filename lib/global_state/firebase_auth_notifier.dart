import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthNotifier extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  bool _isLoading = true; // Estado privado de carregamento inicial

  // Getter público para o estado de carregamento
  bool get isLoading => _isLoading;

  FirebaseAuthNotifier() {
    _initialize();
  }

  void _initialize() {
    // Define _isLoading como verdadeiro ao iniciar
    _isLoading = true;
    notifyListeners();

    // Observa mudanças no estado do Firebase Auth
    _auth.authStateChanges().listen((user) {
      currentUser = user;
      _isLoading = false; // Define como falso após carregar o estado
      notifyListeners();
    });
  }

  // Método para logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await _auth.signOut();
    currentUser = null;
    _isLoading = false;
    notifyListeners();
  }
}
