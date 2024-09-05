import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget{
  final String username;
  const HomePage({required this.username,super.key});
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,//height of appbar
        automaticallyImplyLeading: false, //remove back button
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoSection(image: 'assets/images/mainlogo.png'),
          ],
        ), 
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "Popular",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                    "Your Favourites",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                    "Categories",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      //To place the navbar at bottom of screen
        floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primarycolor,
        onPressed:(){
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) =>
                      const MyApp(),
                    )
                );
        },
        child: const Icon(color: Color(0xffFFFFFF),Icons.add,),
      ),
    );
  }
}