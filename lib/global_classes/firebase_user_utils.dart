import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:star_beauty_app/screens/usuario/signup_screen.dart';

class FirebaseUserUtils {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ///Do not call this method if user is not verified first<br/>
  ///If you do, I'll cosider that you know what you doing
  Future<void> registerUser(UserData user, {Function? onSuccessfull}) async {
    debugPrint("Usuário criado com UID: ${user.uid}");

    // Adiciona os campos ao Firestore
    await _firestore.collection('users').doc(user.uid).set({
      "email": user.email.trim(),
      "name": "",
      "adress": "",
      "profilePicture": "",
      "starBeautyStars": 0,
      "userType": user.type,
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

    onSuccessfull?.call();
  }

  Future<void> deleteUser(User user) async {
    try {
      await user.delete(); // Exclui o usuário do Firebase Authentication
      print("Usuário excluído com sucesso.");
    } on FirebaseAuthException catch (e) {
      print("Erro ao excluir usuário: ${e.message}");
      if (e.code == 'requires-recent-login') {
        print("É necessário fazer login novamente antes de excluir o usuário.");
      }
    } catch (e) {
      print("Erro desconhecido ao excluir o usuário: $e");
    }
  }

  // Future<void> reauthenticateAndDeleteUser(
  //     String email, String password) async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user == null) {
  //       print("Nenhum usuário autenticado.");
  //       return;
  //     }

  //     // Reautentica o usuário
  //     final credential = EmailAuthProvider.credential(
  //       email: email,
  //       password: password,
  //     );
  //     await user.reauthenticateWithCredential(credential);

  //     // Exclui o usuário após a reautenticação
  //     await user.delete();
  //     print("Usuário reautenticado e excluído com sucesso.");
  //   } on FirebaseAuthException catch (e) {
  //     print("Erro ao reautenticar/excluir usuário: ${e.message}");
  //   } catch (e) {
  //     print("Erro desconhecido: $e");
  //   }
  // }

  Future<void> loadUserProgresse({
    Function(List<CourseProgressInfo> loadedInfo)? onSuccessfull,
    Function(Object e)? onFailed,
  }) async {
    try {
      //verificar se o usuário é autenticado
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }

      final docs = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('course_progression')
          .doc('current')
          .get();

      final List<CourseProgressInfo> userProgressInfo = [];

      if (docs.exists) {
        final data = docs.data();

        final List courses = data?['courses'] ?? [];
        if (courses.isNotEmpty) {
          for (int i = 0; i < courses.length; i++) {
            userProgressInfo.add(
              CourseProgressInfo(
                courseID: courses[i]['course_id'],
                lessonsIDs: (courses[i]['lessons_ids'] as List)
                    .map((e) => e.toString())
                    .toList(),
              ),
            );
          }
        }
      }

      onSuccessfull?.call(userProgressInfo);
    } catch (e) {
      onFailed?.call(e);
    }
  }

  Future<void> saveUserProgress(
      {required BuildContext ctx,
      required List<CourseProgressInfo> info,
      Function? onSuccessfull,
      Function? onFailed}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }

      //load user progression

      List<Map<String, dynamic>> progressionTableData = [];
      for (int i = 0; i < info.length; i++) {
        progressionTableData.add({
          'course_id': info[i].courseID,
          'lessons_ids': info[i].lessonsIDs,
        });
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('course_progression')
          .doc('current')
          .set({
        'courses': progressionTableData,
      });

      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Plano de ação salvo com sucesso!')),
      );
      onSuccessfull?.call();
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('Erro ao salvar plano: $e')),
      );
      onFailed?.call();
    }
  }
}

class CourseProgressInfo {
  final String courseID;
  final List<String> lessonsIDs;

  CourseProgressInfo({required this.courseID, required this.lessonsIDs});
}
