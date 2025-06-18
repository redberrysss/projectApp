import 'package:flutter/material.dart';
import 'login_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _buildSectionTitle('Account'),
          _buildTile(
            icon: Icons.person,
            title: 'Profile',
            subtitle: 'Update your personal information',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile tapped')),
              );
            },
          ),
          _buildTile(
            icon: Icons.lock,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change Password tapped')),
              );
            },
          ),
          const Divider(),
          _buildSectionTitle('Preferences'),
          _buildTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage notification settings',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications tapped')),
              );
            },
          ),
          _buildTile(
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Select your language',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language tapped')),
              );
            },
          ),
          const Divider(),
          _buildSectionTitle('Support'),
          _buildTile(
            icon: Icons.help_outline,
            title: 'Help & FAQ',
            onTap: () {},
          ),
          _buildTile(
            icon: Icons.contact_support,
            title: 'Contact Support',
            onTap: () {},
          ),
          const Divider(),
          _buildTile(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.teal[700]),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
