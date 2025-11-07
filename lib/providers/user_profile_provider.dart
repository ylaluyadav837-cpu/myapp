
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padosi/models/user_profile.dart';
import 'package:padosi/services/database_service.dart';

class UserProfileProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final data = await _dbService.getUserData(user.uid);
      if (data != null) {
        _userProfile = UserProfile(
          name: data['name'] ?? 'No Name',
          username: data['email'] ?? 'No Email',
          pronouns: data['pronouns'] ?? '',
          bio: data['bio'] ?? '',
          profileImageUrl: data['profileImageUrl'] ?? 'https://picsum.photos/200/300',
          followers: data['followers'] ?? 0,
          following: data['following'] ?? 0,
          likes: data['likes'] ?? 0,
          comments: data['comments'] ?? 0,
          shares: data['shares'] ?? 0,
        );
        notifyListeners();
      }
    }
  }

  void updateUserProfile(UserProfile newProfile) {
    _userProfile = newProfile;
    final user = _auth.currentUser;
    if (user != null) {
      _dbService.updateUserData(user.uid, newProfile.username, newProfile.name);
    }
    notifyListeners();
  }

  // ... other methods like follow, like, etc. can be updated to interact with the database
}
