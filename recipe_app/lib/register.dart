import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/splash_screen.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'package:recipe_app/widgets/showdialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   final TextEditingController _usernameController = TextEditingController();
    Future<void> sendData(String username) async {
    final url = Uri.parse('http://localhost:3000/api/checkusername'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Register2nd(username: _usernameController.text,),
      ),
      );
    } 
    else{
      showErrorDialog(context, "Username already exists");
    }
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
                          showErrorDialog(context, "Username cannot be empty");
                        }
                        else{
                          sendData(_usernameController.text);
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

  Future<void> sendData(String username,String email,BuildContext context) async {
    final url = Uri.parse('http://localhost:3000/api/checkemail'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PasswordCreation(
            username: username,
            email:email,
          ),
        ),
      );
    } 
    else{
      showErrorDialog(context, "An user with this email already exists");
    }
  }
  Register2nd({required this.username, super.key});
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
                          showErrorDialog(context, "Email cannot be empty");
                        }
                        else{
                          RegExp emailcheck=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if(emailcheck.hasMatch(_emailController.text)==true){
                            sendData(username,_emailController.text, context);
                          }
                          else{
                            showErrorDialog(context, "Please enter appropriate email");
                          }
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
  Future<void> sendData(BuildContext context,String username, String email, String password) async {
    final url = Uri.parse('http://localhost:3000/api/register'); 
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
      savetouserdetails(context, username, email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(screenname: "navbar",username: username,),
        ),
      );
    } else {
      print('Failed to register: ${response.statusCode}');
    }
  }
  Future<void> savetouserdetails(BuildContext context,String username, String email) async {
    final url = Uri.parse('http://localhost:3000/api/savetouserdetails'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print("Saved to user details");
    } else {
      print('Failed to save to user details: ${response.statusCode}');
    }
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
                          showErrorDialog(context, "Please fill all the fields");
                        }
                        else{
                          if (_passwordController.text == _confirmPasswordController.text) {
                            RegExp passcheck=RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).{7,}$');
                            if(passcheck.hasMatch(_passwordController.text)){
                              sendData(context,username, email, _passwordController.text);
                            }
                            else{
                              showErrorDialog(context, "Password does not meet criteria");
                            }
                          } else {
                            showErrorDialog(context, 'Passwords do not match');
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
