
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Create or update user data
  Future<void> updateUserData(String userId, String email, String? name) async {
    try {
      await _dbRef.child('users').child(userId).update({
        'email': email,
        'name': name ?? '',
        'createdAt': ServerValue.timestamp,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Get user data
  Future<Map<dynamic, dynamic>?> getUserData(String userId) async {
    try {
      final snapshot = await _dbRef.child('users').child(userId).get();
      if (snapshot.exists) {
        return snapshot.value as Map<dynamic, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
