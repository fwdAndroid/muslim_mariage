import 'package:flutter/material.dart';
import 'package:muslim_mariage/screens/main/main_dashboard.dart';
import 'package:muslim_mariage/utils/showmesssage.dart';
import 'package:muslim_mariage/widgets/save_button.dart';

class LocationConfrim extends StatefulWidget {
  const LocationConfrim({super.key});

  @override
  State<LocationConfrim> createState() => _LocationConfrimState();
}

class _LocationConfrimState extends State<LocationConfrim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              Icons.location_on,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 16),
            Text(
              "Enable Your Location",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Choose your location to start\nfind people around you",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SaveButton(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => MainDashboard()));
                  showMessageBar("Location Access ", context);
                  // Action for enabling location
                },
                title: "Allow Location Access",
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                showMessageBar("Set Location Later ", context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => MainDashboard()));
                // Action for entering location manually
              },
              child: Text(
                "Enter Location Manually",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
            Spacer(),
            // Optional dashed line design or decorations
          ],
        ),
      ),
    );
  }
}
