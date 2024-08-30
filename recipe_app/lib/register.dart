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
                        const Register2nd(),
                      )
                  );
              },
              ),
            ),
            Spacer(),
            Column(
              children:[
                Image.asset(
                  'assets/images/thinkingman.png',
                  width: MediaQuery.of(context).size.width*0.8, // Makes the image cover the entire width
                  fit: BoxFit.contain, // Ensures the image scales correctly
                ),
              ], 
            ),              
            ],
          ),
        ),
      ),
    );
  }
}

class Register2nd extends StatelessWidget{
  const Register2nd({super.key});
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
                Text('Enter your email address',style: GoogleFonts.leagueSpartan(fontSize:30 ),),
            Textfields(displaytext: 'example@email.com',),
            Padding(
              padding: const EdgeInsets.all(5),
              child:Buttons(
                title: "Continue",
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) =>
                        const PasswordCreation(),
                      )
                  );
              },
              ),
            ),
            Spacer(),
            Column(
              children:[
                Image.asset(
                  'assets/images/emailman.png',
                  width: MediaQuery.of(context).size.width*0.8, // Makes the image cover the entire width
                  fit: BoxFit.contain, // Ensures the image scales correctly
                ),
              ], 
            ),              
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordCreation extends StatelessWidget{
  const PasswordCreation({super.key});
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
                Text('Enter a password for your account',style: GoogleFonts.leagueSpartan(fontSize:30 ),),
            Textfields(displaytext: 'Enter password...',),
            Textfields(displaytext: 'Repeat password...',),
            Padding(
              padding: const EdgeInsets.all(5),
              child:Buttons(
                title: "Complete",
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
            Align(
              alignment: Alignment.topLeft,
            child:Container(
              color:MyColors.minorcolor,
              child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Password Requirements',style: GoogleFonts.leagueSpartan(fontSize:20,color: MyColors.primarycolor ),),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('• Minimum of 7 length',style: GoogleFonts.leagueSpartan(fontSize:20,),),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('• Must include at least a number',style: GoogleFonts.leagueSpartan(fontSize:20,),),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('• Must include a special character',style: GoogleFonts.leagueSpartan(fontSize:20,),),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('• Must include both uppercase and lowercase characters',style: GoogleFonts.leagueSpartan(fontSize:20,),),
                ),
              ],
              ),
            ),

            ),
            ],
          ),
        ),
      ),
    );
  }
}
