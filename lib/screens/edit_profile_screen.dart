import 'package:flutter/material.dart';
import '../models/user_profile.dart';

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

  void _onDone() {
    final updatedProfile = UserProfile(
      name: _nameController.text,
      username: _usernameController.text,
      pronouns: _pronounsController.text,
      bio: _bioController.text,
      profileImageUrl: widget.userProfile.profileImageUrl,
    );
    Navigator.of(context).pop(updatedProfile);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.userProfile.profileImageUrl),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Change profile photo'),
              ),
              const SizedBox(height: 16),
              _buildTextField(label: 'Name', controller: _nameController),
              _buildTextField(label: 'Username', controller: _usernameController),
              _buildTextField(label: 'Pronouns', controller: _pronounsController),
              _buildTextField(label: 'Bio', controller: _bioController, maxLines: 4),
              const SizedBox(height: 16),
              const Divider(),
              _buildTappableField(label: 'Links', value: '1'),
              const Divider(),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Profile information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 8),
              _buildTappableField(label: 'Page', value: 'Connect or create'),
              _buildTappableField(label: 'Category', value: 'Marketing Agency'),
              _buildTappableField(label: 'Contact options', value: 'Email'),
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

  Widget _buildTappableField({required String label, required String value}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: () {},
    );
  }
}
