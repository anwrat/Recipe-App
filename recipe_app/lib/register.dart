import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/navbar.dart';
import 'package:recipe_app/widgets/splash_screen.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   final TextEditingController _usernameController = TextEditingController();
     void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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
          // Background Image
              Align(
                alignment: Alignment.bottomLeft,
                child: Opacity(
                  opacity: 0.2, // Adjust the opacity as needed
                  child: Image.asset(
                    'assets/images/thinkingman.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover, // Ensures the image covers the width properly
                  ),
                ),
              ),
          // Foreground content with buttons
          SingleChildScrollView(
            child:Container(//Aligning horizontally center
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'How would you like everyone to know you?',
                    style: GoogleFonts.leagueSpartan(fontSize: 30),
                  ),
                  Textfields(
                    controller: _usernameController,
                    displaytext: 'Enter your username...',
                    icons: 0xe491,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Buttons(
                      title: "Continue",
                      onPressed: () {
                        if(_usernameController.text.isEmpty){
                          _showDialog(context, "Username cannot be empty");
                        }
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register2nd(username: _usernameController.text,),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}

class Register2nd extends StatelessWidget {
  final String username; // Received from the first screen
  final TextEditingController _emailController = TextEditingController();

  Register2nd({required this.username, super.key});
    void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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
          // Background Image
              Align(
                alignment: Alignment.bottomLeft,
                child: Opacity(
                  opacity: 0.2, // Adjust the opacity as needed
                  child: Image.asset(
                    'assets/images/emailman.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover, // Ensures the image covers the width properly
                  ),
                ),
              ),
          // Foreground content with buttons
          SingleChildScrollView(
            child:Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'Enter your email address',
                    style: GoogleFonts.leagueSpartan(fontSize: 30),
                  ),
                  Textfields(
                    controller: _emailController,
                    displaytext: 'example@email.com',
                    icons: 0xe22a,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Buttons(
                      title: "Continue",
                      onPressed: () {
                        if(_emailController.text.isEmpty){
                          _showDialog(context, "Email cannot be empty");
                        }
                        else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PasswordCreation(
                                username: username,
                                email: _emailController.text,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}

class PasswordCreation extends StatelessWidget {
  final String username;
  final String email;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  PasswordCreation({required this.username, required this.email, super.key});

  // Function to send data to Node.js backend
  Future<void> sendData(String username, String email, String password) async {
    final url = Uri.parse('http://localhost:3000/api/register'); // Change this URL to your backend endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('Registration successful');
    } else {
      print('Failed to register: ${response.statusCode}');
    }
  }
  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
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
          // Foreground content with buttons and other widgets
          SingleChildScrollView(
            child:Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter a password for your account',
                    style: GoogleFonts.leagueSpartan(fontSize: 30),
                  ),
                  Textfields(
                    controller: _passwordController,
                    displaytext: 'Enter password...',
                    icons: 0xe3ae,
                    ispass: true,
                    ),
                  Textfields(
                    controller: _confirmPasswordController,
                    displaytext: 'Repeat password...',
                    icons: 0xe3ae,
                    ispass: true,
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Buttons(
                      title: "Complete",
                      onPressed: () {
                        if(_passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty){
                          _showDialog(context, "Please fill all the fields");
                        }
                        else{
                          if (_passwordController.text == _confirmPasswordController.text) {
                            sendData(username, email, _passwordController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SplashScreen(screenname: "navbar",),
                              ),
                            );
                          } else {
                            _showDialog(context, 'Passwords do not match');
                          }
                        }
                      },
                    ),
                  ),
                  Container(
                    color: MyColors.minorcolor,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password Requirements',
                          style: GoogleFonts.leagueSpartan(
                              fontSize: 20, color: MyColors.primarycolor),
                        ),
                        Text(
                          '• Minimum of 7 length',
                          style: GoogleFonts.leagueSpartan(fontSize: 20),
                        ),
                        Text(
                          '• Must include at least a number',
                          style: GoogleFonts.leagueSpartan(fontSize: 20),
                        ),
                        Text(
                          '• Must include a special character',
                          style: GoogleFonts.leagueSpartan(fontSize: 20),
                        ),
                        Text(
                          '• Must include both uppercase and lowercase characters',
                          style: GoogleFonts.leagueSpartan(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),

            ),
          ),
        ],
      ),
    );
  }
}
