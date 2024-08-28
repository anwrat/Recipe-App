import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/textfields.dart';

class SearchPage extends StatefulWidget{
  const SearchPage();
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Search Page"),
            const Textfields(),
            //Home Button
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(MyColors.primarycolor),
              ),
              //To use a hex color use color class and add 0xff as prefix
              child: const Icon(color: Color(0xffFFFFFF),IconData(0xe318, fontFamily: 'MaterialIcons'),),
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) =>
                      const MyApp(),
                    )
                );
              },
            ),
            //Search Button
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(MyColors.primarycolor),
              ),
              child: const Icon(color: Color(0xffFFFFFF),IconData(0xe567, fontFamily: 'MaterialIcons'),),
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) =>
                      const SearchPage(),
                    )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}