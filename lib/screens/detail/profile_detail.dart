import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/message/message.dart';
import 'package:muslim_mariage/utils/colors.dart';
import 'package:muslim_mariage/widgets/save_button.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/Front view of beautiful man.png"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: black,
                    )),
              )
            ],
          ),
          _buildTextField('About Yourself', null, maxLines: 4),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SaveButton(
                title: "Chat Now",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => Message()));
                }),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData? icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
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
      ),
    );
  }
}
