import 'package:bikerace/global%20widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60),
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/profile/example_profile_picture.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Add other profile information or widgets here
            const Spacer(),
            NavbarWidget(
                activeIndex: 4), // Pass the appropriate active index value here
          ],
        ),
      ),
    );
  }
}
