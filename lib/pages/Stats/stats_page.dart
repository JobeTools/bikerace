import 'package:bikerace/global%20widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Column(
        children: [
          // Add your statistics content here
        ],
      ),
      bottomNavigationBar: NavbarWidget(
        activeIndex: 3,
      ),
    );
  }
}
