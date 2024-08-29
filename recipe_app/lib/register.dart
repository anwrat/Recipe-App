import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/APItest.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/widgets/textfields.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  @override
  State<StatefulWidget> createState() =>  _RegisterState();
}

class _RegisterState extends State<Register> {

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
      body: Align(
        child: SafeArea(
          child: Column(
              children: <Widget>[
                Text('How would you like everyone to know you?',style: GoogleFonts.leagueSpartan(fontSize:30 ),),
            Textfields(displaytext: 'Enter your username',),
            Padding(
              padding: const EdgeInsets.all(5),
              child:Buttons(
                title: "Continue",
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) =>
                        const HTTPExample(),
                      )
                  );
              },
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children:[
                  Image.asset(
                    'assets/images/thinkingman.png',
                    width: MediaQuery.of(context).size.width, // Makes the image cover the entire width
                    fit: BoxFit.contain, // Ensures the image scales correctly
                  ),
                ], 
              ),              
            ),
            ],
          ),
        ),
      ),
    );
  }
}