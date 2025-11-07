
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _desktopNotifications = true;
  bool _directMessages = true;
  bool _groups = true;
  bool _channels = true;
  bool _messageReactions = true;
  bool _notificationPreview = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [
          _buildSwitchTile(
            context,
            title: 'Desktop notifications',
            subtitle: 'To avoid missing out on incoming messages.',
            value: _desktopNotifications,
            onChanged: (value) => setState(() => _desktopNotifications = value),
          ),
          _buildSwitchTile(
            context,
            title: 'Direct messages',
            value: _directMessages,
            onChanged: (value) => setState(() => _directMessages = value),
          ),
          _buildSwitchTile(
            context,
            title: 'Groups',
            value: _groups,
            onChanged: (value) => setState(() => _groups = value),
          ),
          _buildSwitchTile(
            context,
            title: 'Channels',
            value: _channels,
            onChanged: (value) => setState(() => _channels = value),
          ),
          _buildSwitchTile(
            context,
            title: 'Message reactions',
            value: _messageReactions,
            onChanged: (value) => setState(() => _messageReactions = value),
          ),
          const Divider(),
          _buildSwitchTile(
            context,
            title: 'Notification preview',
            subtitle: 'Show message content and sender details in preview.',
            value: _notificationPreview,
            onChanged: (value) => setState(() => _notificationPreview = value),
          ),
          if (_notificationPreview) _buildPreview(context),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Image.network('https://logowik.com/content/uploads/images/google-chrome-2022-new5982.jpg', height: 24, width: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'James',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'via web.arattai.in',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Text('See you later buddy!'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
