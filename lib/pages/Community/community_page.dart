import 'package:bikerace/global%20widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: Column(
        children: [
          // Add your community content here
        ],
      ),
      bottomNavigationBar: NavbarWidget(
        activeIndex: 0,
      ),
    );
  }
}
