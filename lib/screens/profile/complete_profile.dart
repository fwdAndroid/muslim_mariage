import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/profile/upload_photo.dart';
import 'package:muslim_mariage/utils/colors.dart';
import 'package:muslim_mariage/widgets/save_button.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Text(
              'Complete Profile',
              style: TextStyle(
                color: black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Let's Get to Know Each Other",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _buildTextField('Father Name', Icons.person),
              SizedBox(height: 12),
              _buildTextField('Mother Name', Icons.person),
              SizedBox(height: 12),
              _buildTextField('Date of Birth', Icons.calendar_today),
              SizedBox(height: 12),
              _buildTextField('Contact Number', Icons.phone),
              SizedBox(height: 12),
              _buildDropdownField('Your Sect'),
              SizedBox(height: 12),
              _buildDropdownField('Gender'),
              SizedBox(height: 12),
              _buildDropdownField('Matriarchal Status'),
              SizedBox(height: 12),
              _buildTextField('Qualification', null),
              SizedBox(height: 12),
              _buildTextField('Job Occupation', Icons.work),
              SizedBox(height: 12),
              _buildTextField('About Yourself', null, maxLines: 4),
              SizedBox(height: 20),
              SaveButton(
                  title: "Continue",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => UploadPhoto()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData? icon, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }

  Widget _buildDropdownField(String labelText) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }
}
