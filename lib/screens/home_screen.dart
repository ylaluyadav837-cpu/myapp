
import 'package:flutter/material.dart';

class Post {
  final String username;
  final String userAvatarUrl;
  final String imageUrl;
  final String caption;
  bool isLiked;
  bool isSaved;

  Post({
    required this.username,
    required this.userAvatarUrl,
    required this.imageUrl,
    required this.caption,
    this.isLiked = false,
    this.isSaved = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> posts = [
    Post(
      username: 'Padosi User 1',
      userAvatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      imageUrl: 'https://picsum.photos/seed/1/600/800',
      caption: 'Beautiful day in the neighborhood!',
    ),
    Post(
      username: 'Padosi User 2',
      userAvatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
      imageUrl: 'https://picsum.photos/seed/2/600/800',
      caption: 'Anyone have some sugar to spare?',
    ),
    Post(
      username: 'Padosi User 3',
      userAvatarUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
      imageUrl: 'https://picsum.photos/seed/3/600/800',
      caption: 'Just baked some cookies, come on over!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padosi', style: TextStyle(fontFamily: 'Billabong', fontSize: 32.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _buildStories(),
          _buildFeed(),
        ],
      ),
    );
  }

  Widget _buildStories() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100.0,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10, // Placeholder for stories
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/med/men/${index + 10}.jpg'),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'User ${index + 1}',
                    style: const TextStyle(fontSize: 12.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeed() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final post = posts[index];
          return _buildPost(post);
        },
        childCount: posts.length,
      ),
    );
  }

  Widget _buildPost(Post post) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(post),
          _buildPostImage(post),
          _buildPostActions(post),
          _buildPostLikesAndCaption(post),
        ],
      ),
    );
  }

  Widget _buildPostHeader(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(post.userAvatarUrl),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              post.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage(Post post) {
    return Image.network(
      post.imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,
      height: 400,
      loadingBuilder: (context, child, progress) {
        return progress == null ? child : Container(height: 400, color: Colors.grey[300]);
      },
    );
  }

  Widget _buildPostActions(Post post) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            post.isLiked ? Icons.favorite : Icons.favorite_border,
            color: post.isLiked ? Colors.red : null,
          ),
          onPressed: () {
            setState(() {
              post.isLiked = !post.isLiked;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.send_outlined),
          onPressed: () {},
        ),
        const Spacer(),
        IconButton(
          icon: Icon(post.isSaved ? Icons.bookmark : Icons.bookmark_border),
          onPressed: () {
            setState(() {
              post.isSaved = !post.isSaved;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPostLikesAndCaption(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.isLiked ? 'Liked by you and 10 others' : '10 likes',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: '${post.username} ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: post.caption),
              ],
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            'View all 5 comments',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
