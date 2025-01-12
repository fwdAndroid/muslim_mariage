import 'package:flutter/material.dart';
import 'package:muslim_mariage/utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button action
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/Front view of beautiful man.png'), // Replace with your image
            ),
            SizedBox(height: 4),

            // Name Field
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: "Your Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 4),

            // Number Field
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "NUMBER",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: "Contact Number",
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 4),

            // Description Field
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "DESCRIPTION",
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                hintText: "About Yourself",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Save Changes Button
            ElevatedButton(
              onPressed: () {
                // Handle save changes action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text(
                "Save Changes",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
