import 'package:flutter/material.dart';

class RaceLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Race Log'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'Race Log Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
