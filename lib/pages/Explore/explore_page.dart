import 'package:bikerace/global%20widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
      ),
      body: Column(
        children: [
          // Add your explore content here
        ],
      ),
      bottomNavigationBar: NavbarWidget(
        activeIndex: 1,
      ),
    );
  }
}
