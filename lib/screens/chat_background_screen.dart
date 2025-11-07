

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:padosi/screens/color_selection_screen.dart';
import 'package:padosi/screens/wallpaper_selection_screen.dart';

class ChatBackgroundScreen extends StatelessWidget {
  const ChatBackgroundScreen({super.key});

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // For now, just print the path. In a real app, you'd save this.
      print('Image picked: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Background'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Colors'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ColorSelectionScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Wallpapers'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WallpaperSelectionScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Gallery'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _pickImageFromGallery,
          ),
        ],
      ),
    );
  }
}
