import 'package:flutter/material.dart';

class AuthorPanel extends StatelessWidget {
  const AuthorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          'Author Panel',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
