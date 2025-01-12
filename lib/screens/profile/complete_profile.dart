import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:muslim_mariage/screens/profile/upload_photo.dart';
import 'package:muslim_mariage/utils/colors.dart';
import 'package:muslim_mariage/utils/showmesssage.dart';
import 'package:muslim_mariage/widgets/save_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import SpinKit for stylish loader

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  String _selectedSect = 'Sunni'; // Default value
  String _selectedGender = 'Male'; // Default value
  String _selectedMaritalStatus = 'Single'; // Default value
  String _profileCreator = 'Self';

  final TextEditingController _fatherController = TextEditingController();
  final TextEditingController _motherController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _jobOccupationController =
      TextEditingController();
  final TextEditingController _yourselfController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  bool _isLoading = false; // Track loading state
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
              _buildDropdownField('Profile Creator',
                  ['Self', 'Father', 'Mother', 'Brother', "Uncle"],
                  initialValue: _profileCreator),
              SizedBox(height: 12),
              _buildTextField('Father Name', _fatherController, Icons.person),
              SizedBox(height: 12),
              _buildTextField('Mother Name', _motherController, Icons.person),
              SizedBox(height: 12),
              _buildTextField('Full Name', _userNameController, Icons.person),
              SizedBox(height: 12),
              _buildTextField(
                  'Date of Birth', _dobController, Icons.calendar_today),
              SizedBox(height: 12),
              _buildTextField(
                  'Contact Number', _contactNumberController, Icons.phone),
              SizedBox(height: 12),
              _buildDropdownField('Your Sect', ['Sunni', 'Shia'],
                  initialValue: _selectedSect),
              SizedBox(height: 12),
              _buildDropdownField('Gender', ['Male', 'Female'],
                  initialValue: _selectedGender),
              SizedBox(height: 12),
              _buildDropdownField('Marital Status',
                  ['Single', 'Married', 'Divorced', 'Widowed'],
                  initialValue: _selectedMaritalStatus),
              SizedBox(height: 12),
              _buildTextField('Qualification', _qualificationController, null),
              SizedBox(height: 12),
              _buildTextField(
                  'Job Occupation', _jobOccupationController, Icons.work),
              SizedBox(height: 12),
              _buildTextField('About Yourself', _yourselfController, null,
                  maxLines: 4),
              SizedBox(height: 20),
              SaveButton(
                title: "Continue",
                onTap: _saveProfile,
              ),
              if (_isLoading)
                Center(
                  child: SpinKitCircle(
                    color: mainColor,
                    size: 50.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    if (_fatherController.text.isEmpty ||
        _motherController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _contactNumberController.text.isEmpty ||
        _qualificationController.text.isEmpty ||
        _jobOccupationController.text.isEmpty ||
        _yourselfController.text.isEmpty) {
      _showAlert('Please fill all fields before continuing.');
      return;
    }

    FirebaseFirestore.instance.collection('profiles').add({
      'profileCreator': _profileCreator,
      'fatherName': _fatherController.text,
      'motherName': _motherController.text,
      'fullName': _userNameController.text,
      'dob': _dobController.text,
      'contactNumber': _contactNumberController.text,
      'sect': _selectedSect,
      'gender': _selectedGender,
      'maritalStatus': _selectedMaritalStatus,
      'qualification': _qualificationController.text,
      'jobOccupation': _jobOccupationController.text,
      'aboutYourself': _yourselfController.text,
    }).then((_) {
      showMessageBar("Profile Created Successfully", context);
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => UploadPhoto()));
    }).catchError((error) {
      _showAlert('Failed to save profile: $error');
    });
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

  Widget _buildTextField(
      String labelText, TextEditingController controller, IconData? icon,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
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

  Widget _buildDropdownField(String labelText, List<String> items,
      {required String initialValue}) {
    return DropdownButtonFormField<String>(
      value: initialValue,
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
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          if (labelText == "Profile Creator") {
            _profileCreator = newValue!;
          } else if (labelText == 'Your Sect') {
            _selectedSect = newValue!;
          } else if (labelText == 'Gender') {
            _selectedGender = newValue!;
          } else if (labelText == 'Marital Status') {
            _selectedMaritalStatus = newValue!;
          }
        });
      },
    );
  }
}
