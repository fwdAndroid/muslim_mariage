import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:muslim_mariage/screens/profile/location_confrim.dart';
import 'package:muslim_mariage/widgets/save_button.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File? _bridePhoto;
  File? _groomPhoto;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isBridePhoto) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isBridePhoto) {
          _bridePhoto = File(pickedFile.path);
        } else {
          _groomPhoto = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _savePhotos() async {
    if (_bridePhoto == null) {
      _showAlert('Please upload photos.');
      return;
    }

    // Show a loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      // Upload photos to Firebase Storage
      String bridePhotoUrl = await _uploadPhoto(_bridePhoto!, 'bridePhoto');

      // Save photo URLs to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'photo': bridePhotoUrl,
      });

      Navigator.pop(context); // Close the loading indicator
      Navigator.push(
        context,
        MaterialPageRoute(builder: (builder) => LocationConfrim()),
      );
    } catch (e) {
      Navigator.pop(context); // Close the loading indicator
      _showAlert('Failed to upload photos. Please try again.');
    }
  }

  Future<String> _uploadPhoto(File file, String photoType) async {
    String fileName = '$photoType-${DateTime.now().millisecondsSinceEpoch}';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref('uploads/$fileName').putFile(file);

    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Upload Photos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Upload photos for the bride and groom.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Text('Bride Photo'),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _pickImage(true),
                    child: _buildPhotoTile(
                        image: _bridePhoto != null
                            ? FileImage(_bridePhoto!)
                            : null),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(
                title: "Continue",
                onTap: _savePhotos,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoTile({ImageProvider? image}) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 2),
        image: image != null
            ? DecorationImage(image: image, fit: BoxFit.cover)
            : null,
      ),
      child: image == null
          ? Center(
              child: Icon(
                Icons.add,
                color: Colors.green,
                size: 50,
              ),
            )
          : null,
    );
  }
}
