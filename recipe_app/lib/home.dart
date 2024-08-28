import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utils/colors.dart';

class HomePage extends StatefulWidget{
  const HomePage();
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
        ),
      ),
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