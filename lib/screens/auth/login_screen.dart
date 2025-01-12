import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/auth/otp_screen.dart';
import 'package:muslim_mariage/utils/colors.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:muslim_mariage/widgets/save_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();

  String dialCodeDigits = "+91";
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white70),
              margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                children: [
                  CountryCodePicker(
                      onChanged: (country) {
                        setState(() {
                          dialCodeDigits = country.dialCode!;
                        });
                      },
                      initialSelection: "IN",
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      favorite: const ["+91", "IN"]),
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        validator: RequiredValidator(errorText: "Required"),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "12345678",
                          //  prefix: Padding(padding: EdgeInsets.all(10),child: Text(dialCodeDigits,style: TextStyle(color: Colors.black),),),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _controller,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SaveButton(
              title: "Continue",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => VerifyPhone(
                            codeDigits: dialCodeDigits,
                            phone: _controller.text)));
              }),
        ],
      ),
    );
  }
}
