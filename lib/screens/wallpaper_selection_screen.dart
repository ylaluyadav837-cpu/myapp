
import 'package:flutter/material.dart';

class WallpaperSelectionScreen extends StatelessWidget {
  const WallpaperSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Wallpaper'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: 10, // Replace with the actual number of wallpapers
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Set the selected wallpaper as the chat background
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://picsum.photos/200/300?random=$index'), // Replace with your wallpaper images
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
