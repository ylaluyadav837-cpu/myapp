
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padosi/models/user_profile.dart';
import 'package:padosi/providers/user_profile_provider.dart';
import 'package:padosi/services/storage_service.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfileScreen({super.key, required this.userProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _pronounsController;
  late TextEditingController _bioController;

  final StorageService _storageService = StorageService();
  File? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _usernameController = TextEditingController(text: widget.userProfile.username);
    _pronounsController = TextEditingController(text: widget.userProfile.pronouns);
    _bioController = TextEditingController(text: widget.userProfile.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _pronounsController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _pickImage() async {
    final image = await _storageService.pickImage();
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _onDone() async {
    setState(() {
      _isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    String? imageUrl = widget.userProfile.profileImageUrl;
    if (_image != null) {
      imageUrl = await _storageService.uploadProfileImage(user.uid, _image!);
    }

    final updatedProfile = UserProfile(
      name: _nameController.text,
      username: _usernameController.text,
      pronouns: _pronounsController.text,
      bio: _bioController.text,
      profileImageUrl: imageUrl ?? widget.userProfile.profileImageUrl,
    );

    // ignore: use_build_context_synchronously
    Provider.of<UserProfileProvider>(context, listen: false).updateUserProfile(updatedProfile);

    setState(() {
      _isLoading = false;
    });

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        title: const Text('Edit profile', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          TextButton(onPressed: _onDone, child: const Text('Done'))
        ],
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _image != null ? FileImage(_image!) : NetworkImage(widget.userProfile.profileImageUrl) as ImageProvider,
                    ),
                    TextButton(
                      onPressed: _pickImage,
                      child: const Text('Change profile photo'),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Name', controller: _nameController),
                    _buildTextField(label: 'Username', controller: _usernameController),
                    _buildTextField(label: 'Pronouns', controller: _pronounsController),
                    _buildTextField(label: 'Bio', controller: _bioController, maxLines: 4),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
