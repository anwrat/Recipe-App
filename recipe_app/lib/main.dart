import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/login.dart';
import 'package:recipe_app/register.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';//For JSON

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HamroRecipe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primarycolor),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200, // height of appbar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoSection(image: 'assets/images/mainlogo.png'),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image on bottom of page
          Align(
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: 0.2, // Adjust the opacity as needed
            child: Image.asset(
              'assets/images/clouds.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover, // Ensures the image covers the width properly
              ),
            ),
          ),
          // Foreground content with buttons
          SingleChildScrollView(
            child:Container(//Putting inside a container and aligning it to center to horizontally align elements
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      "Everyone can cook, You too!!",
                      style: GoogleFonts.indieFlower(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  // Register Button
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Buttons(
                      title: "Register",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "Already have an account?",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  // Login Text Button
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Log-In',
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 20,
                        color: MyColors.primarycolor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100), // Spacing to prevent overflow
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Test for backend

