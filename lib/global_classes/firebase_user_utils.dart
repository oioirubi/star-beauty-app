import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseUserUtils {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getAllUsers({
    Function(List<Map<String, dynamic>> loadedUsers)? onSuccessfull,
    Function(Object e)? onFailed,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception(
            "Usuário não autenticado"); //caso não, throw uma exception
      }
      final queryUsers = await _firestore.collection('users').get();
      List<Map<String, dynamic>> translatedUsers = [];
      for (int i = 0; i < queryUsers.size; i++) {
        // Get the document snapshot
        final documentSnapshot = queryUsers.docs[i];

        // Convert the document to a Map<String, dynamic>
        final userMap = documentSnapshot.data() as Map<String, dynamic>;
        userMap['uid'] = documentSnapshot.id;
        // Add the map to the list
        translatedUsers.add(userMap);
      }
      onSuccessfull?.call(translatedUsers);
    } catch (e) {
      debugPrint("failed to load users:${e}");
      onFailed?.call(e);
    }
  }

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
