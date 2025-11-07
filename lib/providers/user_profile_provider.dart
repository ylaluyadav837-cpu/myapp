
import 'package:flutter/material.dart';
import 'package:padosi/models/user_profile.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile _userProfile = UserProfile(
    name: 'Ted',
    username: 'ted_graham321',
    pronouns: 'he/him',
    bio: 'Here for a good time',
    profileImageUrl: 'https://picsum.photos/200/300',
    followers: 1134,
    following: 513,
    likes: 10200,
    comments: 210,
    shares: 150,
  );

  UserProfile get userProfile => _userProfile;

  void updateUserProfile(UserProfile newProfile) {
    _userProfile = newProfile;
    notifyListeners();
  }

  void follow() {
    _userProfile.following++;
    notifyListeners();
  }

  void unfollow() {
    _userProfile.following--;
    notifyListeners();
  }

  void like() {
    _userProfile.likes++;
    notifyListeners();
  }

  void unlike() {
    _userProfile.likes--;
    notifyListeners();
  }

  void addComment() {
    _userProfile.comments++;
    notifyListeners();
  }

  void share() {
    _userProfile.shares++;
    notifyListeners();
  }
}
