
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
      ),
      body: ListView(
        children: [
          _buildPrivacyOption(
            context,
            icon: Icons.block,
            title: 'Blocked users',
            value: 'None',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.person,
            title: 'Profile picture',
            value: 'My contacts',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.phone,
            title: 'Phone number',
            value: 'My contacts',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.visibility,
            title: 'Last seen & online',
            value: 'My contacts',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.chat,
            title: 'New chat',
            value: 'Everybody',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.call,
            title: 'Calls',
            value: 'Everybody',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.meeting_room,
            title: 'Meeting invite',
            value: 'Everybody',
            onChanged: (value) {},
          ),
          _buildPrivacyOption(
            context,
            icon: Icons.group_add,
            title: 'Add to groups & channels',
            value: 'Everybody',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        items: <String>['None', 'My contacts', 'Everybody'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
