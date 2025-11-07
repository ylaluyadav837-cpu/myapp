
import 'package:flutter/material.dart';
import 'package:padosi/screens/about_screen.dart';
import 'package:padosi/screens/account_screen.dart';
import 'package:padosi/screens/appearance_screen.dart';
import 'package:padosi/screens/data_storage_screen.dart';
import 'package:padosi/screens/ekyc_screen.dart';
import 'package:padosi/screens/help_screen.dart';
import 'package:padosi/screens/notifications_screen.dart';
import 'package:padosi/screens/personalize_screen.dart';
import 'package:padosi/screens/privacy_screen.dart';
import 'package:padosi/screens/time_management_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Account'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Personalize'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PersonalizeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.visibility_outlined),
            title: const Text('Appearance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppearanceScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage_outlined),
            title: const Text('Data & storage'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DataStorageScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Privacy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('Time management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TimeManagementScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user_outlined),
            title: const Text('eKYC'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EkycScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
