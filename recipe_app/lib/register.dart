import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/navbar.dart';
import 'package:recipe_app/widgets/textfields.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust the opacity to make the image less intrusive
              child: Image.asset(
                'assets/images/thinkingman.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content with buttons
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'How would you like everyone to know you?',
                  style: GoogleFonts.leagueSpartan(fontSize: 30),
                ),
                Textfields(displaytext: 'Enter your username'),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Buttons(
                    title: "Continue",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Register2nd(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Register2nd extends StatelessWidget {
  const Register2nd({super.key});
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
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // Adjust the opacity to make the image less intrusive
              child: Image.asset(
                'assets/images/emailman.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Foreground content with buttons
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Enter your email address',
                  style: GoogleFonts.leagueSpartan(fontSize: 30),
                ),
                Textfields(displaytext: 'example@email.com'),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Buttons(
                    title: "Continue",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordCreation(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PasswordCreation extends StatelessWidget {
  const PasswordCreation({super.key});
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Enter a password for your account',
                  style: GoogleFonts.leagueSpartan(fontSize: 30),
                ),
                Textfields(displaytext: 'Enter password...'),
                Textfields(displaytext: 'Repeat password...'),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Buttons(
                    title: "Complete",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavigationBarApp(),
                        ),
                      );
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
        ],
      ),
    );
  }
}
