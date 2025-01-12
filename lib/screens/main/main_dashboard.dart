import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muslim_mariage/screens/main/pages/home_page.dart';
import 'package:muslim_mariage/screens/main/pages/message_page.dart';
import 'package:muslim_mariage/screens/main/pages/setting_page.dart';
import 'package:muslim_mariage/utils/colors.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(), // Replace with your screen widgets
    MessagePage(),

    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await _showExitDialog(context);
          return shouldPop ?? false;
        },
        child: Scaffold(
          body: _screens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: mainColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  label: "",
                  icon: Icon(_currentIndex == 0 ? Icons.home : Icons.home,
                      color: _currentIndex == 0 ? Colors.white : Colors.black)),
              BottomNavigationBarItem(
                  label: "",
                  icon: Icon(_currentIndex == 1 ? Icons.message : Icons.message,
                      color: _currentIndex == 1 ? Colors.white : Colors.black)),
              BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                      _currentIndex == 2 ? Icons.settings : Icons.settings,
                      color: _currentIndex == 2 ? Colors.white : Colors.black))
            ],
          ),
        ));
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop(); // For Android
              } else if (Platform.isIOS) {
                exit(0); // For iOS
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
