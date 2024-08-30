import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/navbar.dart';

class HomePage extends StatefulWidget{
  const HomePage();
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
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