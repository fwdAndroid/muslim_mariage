import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/profile/complete_profile.dart';
import 'package:muslim_mariage/utils/colors.dart';
import 'package:muslim_mariage/widgets/save_button.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png', // Replace with your icon asset
              height: 200,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Let's start with your \n number",
              style: TextStyle(
                color: black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SaveButton(
              title: "Continue",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => CompleteProfile()));
              }),
          FlutterSocialButton(
            title: "Login with Google",
            titleStyle: TextStyle(color: colorWhite),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => CompleteProfile()));
            },
            buttonType: ButtonType.google,
          )
        ],
      ),
    );
  }
}
