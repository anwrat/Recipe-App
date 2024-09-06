import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'package:recipe_app/widgets/showdialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/settings.dart';

class Createrecipe extends StatelessWidget {

  final String username;
  final TextEditingController _recipename = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _recipedetails = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
  final TextEditingController _instructions = TextEditingController();

  Createrecipe({required this.username,super.key});

  // Function to send data to Node.js backend
  Future<void> sendData(BuildContext context,String recipename,String category, String recipedetails,String ingredients,String instructions) async {
    final url = Uri.parse('http://localhost:3000/api/createrecipe'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'recipename':recipename,
        'category':category ,
        'recipedetails': recipedetails,
        'ingredients':ingredients,
        'instructions':instructions,
      }),
    );

    if (response.statusCode == 200) {
      await showErrorDialog(context, "Password Changed successfully!!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Settings(username: username,),
        ),
      );
    }
    else if(response.statusCode == 401){
      showErrorDialog(context, "Old password is incorrect");
    } else {
      print('Failed to register: ${response.statusCode}');
    }
  }

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
            child:Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Textfields(
                    controller: _recipename,
                    displaytext: '...',
                    ),
                  Textfields(
                    controller: _category,
                    displaytext: '...',
                    ),
                  Textfields(
                    controller: _recipedetails,
                    displaytext: '...',
                    ),
                  Textfields(
                    controller: _ingredients,
                    displaytext: '...',
                    ),
                  Textfields(
                    controller: _instructions,
                    displaytext: '...',
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Buttons(
                      title: "Confirm",
                      onPressed: () {
                        sendData(context, _recipename.text, _category.text,_recipedetails.text, _ingredients.text, _instructions.text);
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
          ),
        ],
      ),
    );
  }
}