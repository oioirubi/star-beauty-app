import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addNotification(String userId, Map<String, dynamic> data) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add(data);
  }
}
