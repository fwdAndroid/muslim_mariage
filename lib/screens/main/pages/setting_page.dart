import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/setting_pages/edit_profile.dart';
import 'package:muslim_mariage/screens/setting_pages/help.dart';
import 'package:muslim_mariage/screens/setting_pages/notification_screen.dart';
import 'package:muslim_mariage/screens/setting_pages/privacy_page.dart';
import 'package:muslim_mariage/screens/setting_pages/subscription_page.dart';
import 'package:muslim_mariage/widgets/logout_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SectionHeader(title: "Account"),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => EditProfile()));
            },
            child: SettingsTile(
              icon: Icons.person,
              title: "Edit profile",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => NotificationScreen()));
            },
            child: SettingsTile(
              icon: Icons.notifications,
              title: "Notifications",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) =>
                          PrivacyPage(title: "Privacy Policy")));
            },
            child: SettingsTile(
              icon: Icons.lock,
              title: "Privacy",
            ),
          ),
          SizedBox(height: 16),
          SectionHeader(title: "Support & About"),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => SubscriptionPage()));
            },
            child: SettingsTile(
              icon: Icons.subscriptions,
              title: "My Subscription",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (builder) => Help()));
            },
            child: SettingsTile(
              icon: Icons.help_outline,
              title: "Help & Support",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) =>
                          PrivacyPage(title: "Terms and Policies")));
            },
            child: SettingsTile(
              icon: Icons.info_outline,
              title: "Terms and Policies",
            ),
          ),
          SizedBox(height: 16),
          SectionHeader(title: "Actions"),
          GestureDetector(
            onTap: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return LogoutWidget();
                },
              );
            },
            child: SettingsTile(
              icon: Icons.logout,
              title: "Log out",
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsTile({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
