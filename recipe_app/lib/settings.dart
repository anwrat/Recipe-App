import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/changepass.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/register.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/buttons.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  State<StatefulWidget> createState() =>  _SettingsState();
}

class _SettingsState extends State<Settings> {

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
            child: Center(
              child:Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    child:Text(
                      "Don't have an account?",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 20,
                      ),),
                    padding: const EdgeInsets.only(top: 30),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap:(){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangePass()));
                    },
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconData(0xf052b, fontFamily: 'MaterialIcons'),color: MyColors.primarycolor,size: 40,),
                        Text(
                          'Change Password',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            color: MyColors.mainblack,
                            fontWeight: FontWeight.w500,
                          ),), 
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Buttons(
                    title: "Log-Out", 
                    icons: Icon(IconData(0xe57f, fontFamily: 'MaterialIcons'),color:MyColors.mainwhite ,size: 30,),
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    }),
              ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}