import 'package:flutter/material.dart';
import 'package:padosi/providers/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:go_router/go_router.dart';

class TadkaScreen extends StatefulWidget {
  const TadkaScreen({super.key});

  @override
  State<TadkaScreen> createState() => _TadkaScreenState();
}

class _TadkaScreenState extends State<TadkaScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isLiked = false;
  bool isFollowed = false;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      if (isMuted) {
        _controller.setVolume(0.0);
      } else {
        _controller.setVolume(1.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text('Explore', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  if (!_controller.value.isPlaying)
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  _buildVideoOverlay(userProfileProvider),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildVideoOverlay(UserProfileProvider userProfileProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => context.go('/profile'),
                          child: Text(
                            userProfileProvider.userProfile.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isFollowed = !isFollowed;
                            });
                            if (isFollowed) {
                              userProfileProvider.follow();
                            } else {
                              userProfileProvider.unfollow();
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            backgroundColor: isFollowed ? Colors.white : Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(isFollowed ? 'Following' : 'Follow', style: TextStyle(color: isFollowed ? Colors.black : Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Description of the video goes here...',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionButton(
                    icon: isMuted ? Icons.volume_off : Icons.volume_up,
                    label: '',
                    onTap: _toggleMute,
                  ),
                  const SizedBox(height: 20),
                  _buildActionButton(icon: isLiked ? Icons.favorite : Icons.favorite_border, label: '${userProfileProvider.userProfile.likes}', onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    if (isLiked) {
                      userProfileProvider.like();
                    } else {
                      userProfileProvider.unlike();
                    }
                  }, color: isLiked ? Colors.red : Colors.white),
                  const SizedBox(height: 20),
                  _buildActionButton(icon: Icons.comment_bank_outlined, label: '${userProfileProvider.userProfile.comments}', onTap: () {
                    _showCommentsBottomSheet(context, userProfileProvider);
                  }),
                  const SizedBox(height: 20),
                  _buildActionButton(icon: Icons.send, label: 'Share', onTap: () {
                    _showShareBottomSheet(context, userProfileProvider);
                  }),
                  const SizedBox(height: 20),
                  _buildActionButton(icon: Icons.more_horiz, label: '', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap, Color color = Colors.white}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context, UserProfileProvider userProfileProvider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Comments', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 20, // dummy data
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Text('U'),
                        ),
                        title: Text('User $index', style: const TextStyle(color: Colors.white)),
                        subtitle: const Text('This is a comment.', style: TextStyle(color: Colors.white70)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.black26,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          userProfileProvider.addComment();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showShareBottomSheet(BuildContext context, UserProfileProvider userProfileProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Share to', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.group, color: Colors.white),
                      title: const Text('Group', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        userProfileProvider.share();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.book, color: Colors.white),
                      title: const Text('Your Story', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        userProfileProvider.share();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.link, color: Colors.white),
                      title: const Text('Copy Link', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        userProfileProvider.share();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.more_horiz, color: Colors.white),
                      title: const Text('More', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        userProfileProvider.share();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
