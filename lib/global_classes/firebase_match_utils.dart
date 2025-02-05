import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMatchUtils {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadUserLike({
    required String userID,
    Function(List<Map<String, dynamic>>)? onSuccessfull,
    Function? onFailed,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }

      var likesDatabase = await _firestore
          .collection('match')
          .doc(userID)
          .collection('current')
          .doc('likes')
          .get();

      List<Map<String, dynamic>> likesConverted = [];
      if (likesDatabase.exists) {
        for (var i = 0; i < likesDatabase.data()!.length; i++) {
          likesConverted.add({
            'userID': _auth.currentUser!.uid,
            'time': DateTime.now(),
          });
        }
      }

      debugPrint('like enviado com sucesso!');
      onSuccessfull?.call(likesConverted);
    } catch (e) {
      debugPrint('Erro ao enviar like: $e');
      onFailed?.call();
    }
  }

  Future<void> sendUserLike({
    required String toUserID,
    Function? onSuccessfull,
    Function? onFailed,
  }) async {
    try {
      final thisUser = _auth.currentUser;
      if (thisUser == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }

      List<Map<String, dynamic>> likeTable = [];
      await loadUserLike(
          userID: thisUser.uid,
          onSuccessfull: (p0) {
            likeTable = p0;
          },
          onFailed: () {
            throw Exception("failed to load user likes");
          });

      likeTable.add({
        'userID': _auth.currentUser!.uid,
        'time': DateTime.now(),
      });

      await _firestore.collection('match').doc(toUserID).set({
        'likeTable': likeTable,
      });

      debugPrint('like enviado com sucesso!');
      onSuccessfull?.call();
    } catch (e) {
      debugPrint('Erro ao enviar like: $e');
      onFailed?.call();
    }
  }
}
