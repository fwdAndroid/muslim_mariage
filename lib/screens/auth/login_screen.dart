import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/main/main_dashboard.dart';
import 'package:muslim_mariage/screens/profile/complete_profile.dart';
import 'package:muslim_mariage/services/auth_methods.dart';
import 'package:muslim_mariage/utils/colors.dart';
import 'package:muslim_mariage/utils/showmesssage.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isGoogle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: 20),
          isGoogle
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: FlutterSocialButton(
                      buttonType: ButtonType.google,
                      onTap: () async {
                        setState(() {
                          isGoogle = true;
                        });

                        await AuthMethods().signInWithGoogle();

                        try {
                          // Get the UserCredential object

                          final userDoc = await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get();

                          if (userDoc.exists) {
                            // Retrieve user data
                            final userData = userDoc.data();
                            final fullName = userData?['fullName'];

                            // Check if any field is null or empty
                            if ((fullName == null || fullName.isEmpty) ||
                                (phone == null || phone.isEmpty) ||
                                (location == null || location.isEmpty)) {
                              // Navigate to ProfilePage1 to complete the profile
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => CompleteProfile()),
                              );
                            } else {
                              // All fields are valid, navigate to MainDashboard
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => MainDashboard()),
                              );
                            }
                          } else {
                            // If the user does not exist, create a new document
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .set({
                              "image":
                                  FirebaseAuth.instance.currentUser!.photoURL,
                              "email": FirebaseAuth.instance.currentUser!.email,
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "fullName": "",
                              "phone": "",
                              "location": "",
                            });

                            // Navigate to ProfilePage1 for new users
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => CompleteProfile()),
                            );
                          }
                        } catch (e) {
                          showMessageBar(
                              "Error during sign-in. Please try again. $e",
                              context);
                        }

                        setState(() {
                          isGoogle = false;
                        });
                      }),
                )
        ],
      ),
    );
  }
}
