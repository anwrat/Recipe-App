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
  final TextEditingController _image = TextEditingController();
  final TextEditingController _recipename = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _recipedetails = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
  final TextEditingController _instructions = TextEditingController();

  Createrecipe({required this.username,super.key});

  // Function to send data to Node.js backend
  Future<void> sendData(BuildContext context,String image,String recipename,String owner,String category, String recipedetails,String ingredients,String instructions) async {
    final url = Uri.parse('http://localhost:3000/api/createrecipe'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'image':image,
        'recipename':recipename,
        'owner':owner,
        'category':category ,
        'recipedetails': recipedetails,
        'ingredients':ingredients,
        'instructions':instructions,
      }),
    );

    if (response.statusCode == 200) {
      await showErrorDialog(context, "Recipe Created successfully!!");
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => Settings(username: username,),
        ),
      );
    }
    else if(response.statusCode == 409){
      showErrorDialog(context, "Recipe/Recipe Name already exists");
    } else {
      print('Failed to create recipe: ${response.statusCode}');
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
                  Text(
                    'Image of Recipe',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Textfields(
                    controller: _image,
                    displaytext: 'Paste URL of image here...',
                    ),
                  Text(
                    'Name of Recipe',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Textfields(
                    controller: _recipename,
                    displaytext: '...',
                    ),
                  Text(
                    'Category',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Textfields(
                    controller: _category,
                    displaytext: '...',
                    ),
                  Text(
                    'Details about recipe',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Textfields(
                    controller: _recipedetails,
                    displaytext: '...',
                    ),
                  Text(
                    'Ingredients Required',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Textfields(
                    controller: _ingredients,
                    displaytext: '...',
                    ),
                  Text(
                    'Instructions',
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
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
                        sendData(context,_image.text, _recipename.text,username, _category.text,_recipedetails.text, _ingredients.text, _instructions.text);
                      },
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