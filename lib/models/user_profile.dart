
class UserProfile {
  String name;
  String username;
  String pronouns;
  String bio;
  String profileImageUrl;
  int followers;
  int following;
  int likes;
  int comments;
  int shares;

  UserProfile({
    required this.name,
    required this.username,
    required this.pronouns,
    required this.bio,
    required this.profileImageUrl,
    this.followers = 0,
    this.following = 0,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });
}
