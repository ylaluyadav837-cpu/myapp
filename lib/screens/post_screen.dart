
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  XFile? _mediaFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _mediaFile = pickedFile;
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);
    if (pickedFile != null) {
      setState(() {
        _mediaFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement post logic
            },
            child: const Text('Post', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_mediaFile != null)
              SizedBox(
                height: 300,
                width: double.infinity,
                child: _mediaFile!.path.endsWith('.mp4')
                    ? const Center(child: Text("Video selected")) // Placeholder for video player
                    : Image.file(File(_mediaFile!.path), fit: BoxFit.cover),
              )
            else
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Text('No media selected.'),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
              ],
            ),
             const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickVideo(ImageSource.gallery),
                  icon: const Icon(Icons.video_library),
                  label: const Text('Video Gallery'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickVideo(ImageSource.camera),
                  icon: const Icon(Icons.videocam),
                  label: const Text('Record Video'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
