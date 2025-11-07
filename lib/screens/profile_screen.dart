
import 'package:flutter/material.dart';
import 'package:padosi/models/user_profile.dart';
import 'package:padosi/providers/user_profile_provider.dart';
import 'package:padosi/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the user profile when the screen is initialized
    Provider.of<UserProfileProvider>(context, listen: false).fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
        final userProfile = userProfileProvider.userProfile;

        if (userProfile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [SliverToBoxAdapter(child: _buildProfileHeader(context, userProfile, userProfileProvider))];
            },
            body: TabBarView(
              children: [
                _buildPostGrid(),
                const Center(child: Text('Coming Soon!')),
                const Center(child: Text('Coming Soon!')),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserProfile userProfile, UserProfileProvider userProfileProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(userProfile.profileImageUrl),
                  ),
                  const SizedBox(height: 8),
                  Text(userProfile.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(userProfile.pronouns, style: const TextStyle(color: Colors.grey)),
                  Text(userProfile.bio),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('84', 'posts'),
                        _buildStatColumn(userProfile.followers.toString(), 'followers'),
                        _buildStatColumn(userProfile.following.toString(), 'following'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn(userProfile.likes.toString(), 'Likes'),
                        _buildStatColumn(userProfile.comments.toString(), 'Comments'),
                        _buildStatColumn(userProfile.shares.toString(), 'Shares'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final updatedProfile = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(userProfile: userProfile),
                ),
              );
              if (updatedProfile != null) {
                userProfileProvider.updateUserProfile(updatedProfile);
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 36), // full width
            ),
            child: const Text('Edit profile'),
          ),
          const SizedBox(height: 16),
          const TabBar(
            indicatorColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.video_collection_outlined)),
              Tab(icon: Icon(Icons.person_pin_outlined)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildPostGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return Image.network('https://picsum.photos/200/200?random=$index');
      },
      itemCount: 12, // Number of posts
    );
  }
}
