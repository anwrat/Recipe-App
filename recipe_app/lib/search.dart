import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<StatefulWidget> createState() =>  _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width*0.5,
                          child: TextField(
                              decoration: InputDecoration(
                                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color.fromRGBO(217, 217, 217, 1)),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                border: const OutlineInputBorder(),
                                hintText: "Type to search....",
                                hintStyle: GoogleFonts.leagueSpartan(
                                  fontSize: 20,
                                  color: Color.fromRGBO(156, 163, 175, 1),
                                ),
                              ),
                            ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(MyColors.primarycolor),
                              shape: WidgetStatePropertyAll(
                                const CircleBorder(), 
                              ),
                              padding: WidgetStatePropertyAll(
                                const EdgeInsets.all(20), 
                              ),
                          ),
                          child: const Icon(color: MyColors.mainwhite,IconData(0xe567, fontFamily: 'MaterialIcons'),size:30,),
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
                  const SizedBox(
                    height: 30.0,
                  ),
              ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}