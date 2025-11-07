import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:padosi/screens/search_screen.dart';
import 'package:padosi/screens/post_screen.dart';
import 'package:padosi/screens/map_screen.dart';
import 'package:padosi/screens/profile_screen.dart';

// Data Models
class Post {
  final String username;
  final String userAvatarUrl;
  final String imageUrl;
  final String caption;
  bool isLiked;
  bool isSaved;
  bool isMuted;
  bool isFollowing;

  Post({
    required this.username,
    required this.userAvatarUrl,
    required this.imageUrl,
    required this.caption,
    this.isLiked = false,
    this.isSaved = false,
    this.isMuted = false,
    this.isFollowing = false,
  });
}

class Story {
  final String username;
  final String userAvatarUrl;
  final String storyUrl;

  Story({required this.username, required this.userAvatarUrl, required this.storyUrl});
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Placeholder data
  final List<Post> posts = [
    Post(
      username: 'art_lover_23',
      userAvatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      imageUrl: 'https://picsum.photos/seed/1/600/800',
      caption: 'Beautiful day in the neighborhood!',
    ),
    Post(
      username: 'foodie_explorer',
      userAvatarUrl: '', // Blank URL for placeholder
      imageUrl: 'https://picsum.photos/seed/2/600/800',
      caption: 'Anyone have some sugar to spare?',
    ),
  ];

  final List<Story> stories = [
    Story(username: 'You', userAvatarUrl: 'https://randomuser.me/api/portraits/men/9.jpg', storyUrl: 'https://picsum.photos/seed/s1/900/1600'),
    Story(username: 'Neighbor 1', userAvatarUrl: 'https://randomuser.me/api/portraits/women/10.jpg', storyUrl: 'https://picsum.photos/seed/s2/900/1600'),
    Story(username: 'Neighbor 2', userAvatarUrl: 'https://randomuser.me/api/portraits/men/11.jpg', storyUrl: 'https://picsum.photos/seed/s3/900/1600'),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    _HomeScreenContent(),
    SearchScreen(),
    PostScreen(),
    MapScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padosi', style: TextStyle(fontFamily: 'Billabong', fontSize: 32.0)),
        actions: [
          if (_selectedIndex != 4) ...[
            IconButton(
              icon: const Icon(Icons.local_fire_department_outlined),
              onPressed: () => context.go('/tadka'),
            ),
            IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.send_outlined),
              onPressed: () {
                // TODO: Implement message screen navigation
              },
            ),
          ] else ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
            IconButton(onPressed: () => context.go('/settings'), icon: const Icon(Icons.menu)),
          ]
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomeScreenState>()!;
    return CustomScrollView(
      slivers: [
        _buildStories(context, state.stories),
        _buildFeed(context, state.posts, state),
      ],
    );
  }

  Widget _buildStories(BuildContext context, List<Story> stories) {
    return SliverToBoxAdapter(
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          itemBuilder: (context, index) {
            final story = stories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () => context.go('/story/${story.username}'),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: story.userAvatarUrl.isNotEmpty ? NetworkImage(story.userAvatarUrl) : null,
                      child: story.userAvatarUrl.isEmpty ? const Icon(Icons.person, size: 30) : (index == 0 ? const Icon(Icons.add, color: Colors.white) : null),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      story.username,
                      style: const TextStyle(fontSize: 12.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildFeed(BuildContext context, List<Post> posts, _HomeScreenState state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildPost(context, posts[index], state),
        childCount: posts.length,
      ),
    );
  }

  Widget _buildPost(BuildContext context, Post post, _HomeScreenState state) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(context, post, state),
          _buildPostImage(context, post),
          _buildPostActions(context, post, state),
          _buildPostLikesAndCaption(context, post),
        ],
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context, Post post, _HomeScreenState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: post.userAvatarUrl.isNotEmpty ? NetworkImage(post.userAvatarUrl) : null,
            child: post.userAvatarUrl.isEmpty ? const Icon(Icons.person) : null,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: InkWell(
              onTap: () => context.go('/profile/${post.username}'),
              child: Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          TextButton(
            child: Text(post.isFollowing ? 'Unfollow' : 'Follow'),
            onPressed: () {
              state.setState(() {
                post.isFollowing = !post.isFollowing;
              });
            },
          ),
          IconButton(
            icon: Icon(post.isMuted ? Icons.volume_off : Icons.volume_up),
            onPressed: () {
              state.setState(() {
                post.isMuted = !post.isMuted;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.report),
                        title: const Text('Report'),
                        onTap: () {
                          // Handle report
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.block),
                        title: const Text('Block'),
                        onTap: () {
                          // Handle block
                          Navigator.pop(context);
                        },
                      ),
                       ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Settings'),
                        onTap: () {
                           context.go('/settings');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage(BuildContext context, Post post) {
    return Image.network(post.imageUrl, fit: BoxFit.cover, width: double.infinity, height: 400);
  }

  Widget _buildPostActions(BuildContext context, Post post, _HomeScreenState state) {
    return Row(
      children: [
        IconButton(
          icon: Icon(post.isLiked ? Icons.favorite : Icons.favorite_border, color: post.isLiked ? Colors.red : null),
          onPressed: () => state.setState(() => post.isLiked = !post.isLiked),
        ),
        IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
        IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
        const Spacer(),
        IconButton(
          icon: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_border),
          onPressed: () => state.setState(() => post.isSaved = !post.isSaved),
        ),
      ],
    );
  }

  Widget _buildPostLikesAndCaption(BuildContext context, Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.isLiked ? 'Liked by you and others' : '10 likes', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4.0),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [TextSpan(text: '${post.username} ', style: const TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: post.caption)],
            ),
          ),
        ],
      ),
    );
  }
}