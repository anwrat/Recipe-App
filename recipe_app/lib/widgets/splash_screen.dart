import 'package:flutter/material.dart';
import 'dart:async';
import 'package:recipe_app/register.dart';
import 'package:recipe_app/widgets/navbar.dart';

class SplashScreen extends StatelessWidget {
  final String? screenname;
  const SplashScreen({super.key,required this.screenname});
  @override
  Widget build(BuildContext context) {
    final Map<String, Widget> screenMap = {
      'register': Register(),
      'navbar':NavigationBarApp(), // Add other screens as needed
    };
    // Delay navigation to the next page
    Future.delayed(Duration(seconds: 1), () {
      final targetScreen = screenMap[screenname];
      if (targetScreen != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      }
    });

    return Scaffold(
      backgroundColor:  Color.fromRGBO(255, 248, 247,1),
      body: Center(
        child: Image.asset(
          'assets/images/mainlogo.png', // Replace with image asset path
          width: MediaQuery.of(context).size.width*0.5, 
          height: MediaQuery.of(context).size.height*0.5, 
          fit: BoxFit.contain, 
        ),
      ),
    );
  }
}
