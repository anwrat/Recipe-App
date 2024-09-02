import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/register.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/navbar.dart';
import 'package:recipe_app/widgets/textfields.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() =>  _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailField =  TextEditingController();
  final TextEditingController _passwordField =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,//height of appbar
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoSection(image: 'assets/images/mainlogo.png'),
          ],
        ), 
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Log-In',style: GoogleFonts.leagueSpartan(fontSize:30 ),),
                const SizedBox(
                  height: 30.0,
                ),
                Textfields(displaytext:"Enter your username..",icons: 0xe491,),
                Textfields(displaytext:"Enter password...",icons: 0xe3ae,ispass: true,),
            Padding(
              padding: const EdgeInsets.all(5),
              child:Buttons(
                title: "Login",
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) =>
                        const NavigationBarApp(),
                      )
                  );
              },
              ),
            ),
            Padding(
              child:Text(
                "Don't have an account?",
                style: GoogleFonts.leagueSpartan(
                  fontSize: 20,
                ),),
              padding: const EdgeInsets.only(top: 30),
            ),
            InkWell(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Register()));
              },
              child: Text(
                'Sign-Up',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 20,
                  color: MyColors.primarycolor,
                ),), 
            ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}