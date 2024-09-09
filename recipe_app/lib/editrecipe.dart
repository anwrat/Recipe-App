import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/displayrecipe.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/textfield2.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'package:recipe_app/widgets/showdialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditRecipe extends StatefulWidget {
  final String recipename;

  const EditRecipe({required this.recipename, super.key});

  @override
  State<EditRecipe> createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  String previmg='';
  String owner='';
  String prevcat='';
  String prevdetails='';
  String previngredients='';
  String previnstructions='';
  final TextEditingController _image = TextEditingController();
  final TextEditingController _recipename = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _recipedetails = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  bool isLoading = true;

  // Function to fetch current recipe data
  Future<void> fetchRecipeData() async {
    final url = Uri.parse('http://localhost:3000/api/getrecipe');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'recipename': widget.recipename}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body); 
        if (data.isNotEmpty && data.first is Map<String, dynamic>){
          final recipe = data.first as Map<String, dynamic>;
          setState(() {
            _recipename.text=recipe['recipename'].toString();
            _category.text=recipe['category'].toString();
            _recipedetails.text=recipe['recipedetails'].toString();
            _ingredients.text=recipe['ingredients'].toString();
            _instructions.text=recipe['instructions'].toString();
            owner=recipe['owner'].toString();
            previmg = recipe['image'].toString();
            prevcat=recipe['category'].toString();
            prevdetails=recipe['recipedetails'].toString();
            previngredients=recipe['ingredients'].toString();
            previnstructions=recipe['instructions'].toString();
            isLoading = false;
          });
        }
      } else {
        print('Failed to fetch recipe: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching recipe: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to send edited data to Node.js backend
  Future<void> sendData(BuildContext context, String orgname, String image, String recipename, String category ,String recipedetails,String ingredients,String instructions) async {
    final url = Uri.parse('http://localhost:3000/api/editrecipe');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'orgname': orgname,
        'image': image,
        'recipename': recipename,
        'category': category,
        'recipedetails': recipedetails,
        'ingredients': ingredients,
        'instructions': instructions,
      }),
    );

    if (response.statusCode == 200) {
      await showErrorDialog(context, "Recipe Edited successfully!!");
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => Displayrecipe(recipename: recipename,username: owner,),
        ),
      );
    } else {
      print('Failed to edit recipe: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipeData(); // Fetch existing profile data when the screen loads
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Foreground content with buttons and other widgets
                SingleChildScrollView(
                  child: Container(
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
                        Textfields2(
                          controller: _recipedetails,
                          displaytext: '...',
                          ),
                        Text(
                          'Ingredients Required',
                          style: GoogleFonts.leagueSpartan(
                          fontSize: 20, color: MyColors.mainblack,
                          fontWeight: FontWeight.bold),
                        ),
                        Textfields2(
                          controller: _ingredients,
                          displaytext: '...',
                          ),
                        Text(
                          'Instructions',
                          style: GoogleFonts.leagueSpartan(
                          fontSize: 20, color: MyColors.mainblack,
                          fontWeight: FontWeight.bold),
                        ),
                        Textfields2(
                          controller: _instructions,
                          displaytext: '...',
                          ),
                        Align(
                          alignment: Alignment.center,
                          child: Buttons(
                            title: "Confirm",
                            onPressed: () {
                              sendData(
                                context,
                                widget.recipename,
                                _image.text.isEmpty
                                    ? previmg
                                    : _image.text,
                                _recipename.text.isEmpty
                                    ? widget.recipename
                                    : _recipename.text,
                                _category.text.isEmpty
                                    ? prevcat
                                    : _category.text,
                                _recipedetails.text.isEmpty
                                    ? prevdetails
                                    : _recipedetails.text,
                                _ingredients.text.isEmpty
                                    ? previngredients
                                    : _ingredients.text,
                                _instructions.text.isEmpty
                                    ? previnstructions
                                    : _instructions.text,
                              );
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
