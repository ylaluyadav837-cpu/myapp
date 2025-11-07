
import 'package:flutter/material.dart';
import 'dart:async';

class StoryScreen extends StatefulWidget {
  final String username;

  const StoryScreen({super.key, required this.username});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  // Placeholder for story items
  final List<String> storyItems = [
    'https://picsum.photos/seed/s1/900/1600',
    'https://picsum.photos/seed/s2/900/1600',
    'https://picsum.photos/seed/s3/900/1600',
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _controller.forward();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < storyItems.length - 1) {
        setState(() {
          _currentIndex++;
          _controller.reset();
          _controller.forward();
        });
      } else {
        _timer.cancel();
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: _controller.value,
              backgroundColor: Colors.grey[700],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/10.jpg'),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.username,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Image.network(
                storyItems[_currentIndex],
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
