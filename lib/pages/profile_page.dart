import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page"), centerTitle: true),
      body: Center(
        child: Text("Coming Soon...", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
