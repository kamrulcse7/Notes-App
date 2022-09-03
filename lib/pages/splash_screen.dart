import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(milliseconds: 2500),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      ),
    );
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 130.0,
        ),
      ),
    );
  }
}
