import 'package:flutter/material.dart';
import 'package:recipe_app/editrecipe.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/widgets/showdialog.dart';

class Displayrecipe extends StatefulWidget {

  final String username;
  final String recipename;

  const Displayrecipe({required this.username,required this.recipename,super.key});

  @override
  State<Displayrecipe> createState() => _DisplayrecipeState();
}

class _DisplayrecipeState extends State<Displayrecipe> {

  String image='';
  String owner='';
  String category='';
  String recipeDetails = '';
  String ingredients = '';
  String instructions = '';
  List <dynamic> fav=[];
  bool isLoading = true;
  bool isFavorite = true;

  // Function to send data to Node.js backend
  Future<void> getData(BuildContext context,String recipename) async {
    final url = Uri.parse('http://localhost:3000/api/getrecipe'); 
    try{
      final response = await http.post(url,headers: {'Content-Type': 'application/json'},body: jsonEncode({'recipename': recipename}),);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        
        if (data.isNotEmpty && data.first is Map<String, dynamic>) {
          final recipe = data.first as Map<String, dynamic>;
          // Update state variables with fetched data
          setState(() {
            image=recipe['image'].toString();
            owner=recipe['owner'].toString();
            category=recipe['category'].toString();
            recipeDetails = recipe['recipedetails'].toString();
            ingredients = recipe['ingredients'].toString() ;
            instructions = recipe['instructions'].toString();
            isLoading = false;
          });
        }
      }
      else {
        print('Failed to fetch recipe: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    }catch(error){
      print('Error fetching recipe: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

// Function to delete the recipe
  Future<void> deleteRecipe(String recipename) async {
    final url = Uri.parse('http://localhost:3000/api/deleterecipe'); 
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'recipename': recipename}),
      );

      if (response.statusCode == 200) {
        await showErrorDialog(context, "Recipe Deleted successfully!!");
        Navigator.pop(context); 
      } else {
        print('Failed to delete recipe: ${response.statusCode}');
        showErrorDialog(context, "Unexpected error ${response.statusCode}");
      }
    } catch (error) {
      print('Error deleting recipe: $error');
      showErrorDialog(context, "Unexpected error: ${error}");
    }
  }

  Future<void> getuserdetails(BuildContext context,String username) async {
    final url = Uri.parse('http://localhost:3000/api/getuserdetails'); 
    try{
      final response = await http.post(url,headers: {'Content-Type': 'application/json'},body: jsonEncode({'username': username}),);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        
        if (data.isNotEmpty && data.first is Map<String, dynamic>) {
          final user = data.first as Map<String, dynamic>;
          // Update state variables with fetched data
          setState(() {
            fav=user['favourites'];
            isLoading = false;
          });
          checkIfFavorite();
        }
      }
      else {
        print('Failed to fetch userdetail: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    }catch(error){
      print('Error fetching userdetail: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to handle adding to or removing from favorites
Future<void> checkIfFavorite() async {
  final url = Uri.parse('http://localhost:3000/api/checkfav');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': widget.username,
        'recipename': widget.recipename,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if(responseData['message']=='Y'){
        setState(() {
          isFavorite = true; // Toggle the favorite status
        });
      }
      else{
        setState(() {
          isFavorite = false; // Toggle the favorite status
        });
      }
    } 
    else{
      print('Failed checking favorites: ${response.statusCode}');
    }
  } catch (error) {
    print('Error checking: $error');
    showErrorDialog(context, 'Error checking favorites');
  }
}

  // Function to handle adding to or removing from favorites
Future<void> toggleFavoriteStatus() async {
  final url = Uri.parse('http://localhost:3000/api/editfav');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': widget.username,
        'recipename': widget.recipename,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      // Successfully added to favorites
      setState(() {
        isFavorite = !isFavorite; // Toggle the favorite status
      });
       await showErrorDialog(context, responseData['message']);
    } else {
      print('Failed to add to favorites: ${response.statusCode}');
    }
  } catch (error) {
    print('Error adding to favorites: $error');
  }
}

  @override
  void initState() {
    super.initState();
    getData(context, widget.recipename);
    getuserdetails(context, widget.username);
  }

  // Show confirmation dialog
  void showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this recipe?',style: GoogleFonts.leagueSpartan(fontSize: 20,)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('No',style: GoogleFonts.leagueSpartan(fontSize: 20,color: MyColors.primarycolor)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
                deleteRecipe(widget.recipename); 
              },
              child: Text('Yes',style: GoogleFonts.leagueSpartan(fontSize: 20,color: MyColors.primarycolor)),
            ),
          ],
        );
      },
    );
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
      ? const Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
      : Stack(
        children: [
          // Foreground content with buttons and other widgets
          SingleChildScrollView(
            child:Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        widget.recipename,
                        style: GoogleFonts.leagueSpartan(
                        fontSize: 30, color: MyColors.mainblack,
                        fontWeight: FontWeight.bold),
                      ),
                      if(widget.username==owner)...[
                        InkWell(
                          onTap:(){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>EditRecipe(recipename: widget.recipename,)));
                          },
                          child: Icon(CupertinoIcons.pencil,color: MyColors.primarycolor,size: 40,),
                        ),    
                        InkWell(
                          onTap:(){
                            showDeleteConfirmation();
                          },
                          child: Icon(IconData(0xe1b9, fontFamily: 'MaterialIcons'),color: MyColors.primarycolor,size: 40,),
                        ),            
                      ], //Show edit icon only if user is the owner of recipe
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300, 
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          blurRadius: 5, // Shadow blur radius
                          offset: Offset(2, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.leagueSpartan(
                      fontSize: 10, color: MyColors.mainblack,),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ClipOval(
                    child: Image.network(
                      image, 
                      width: 100.0, 
                      height: 100.0,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(
                          Icons.error, 
                          color: Colors.red,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Uploaded by: "+owner,
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 16, color: MyColors.mainblack,),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                      onTap:(){
                         setState(() {
                              toggleFavoriteStatus();
                            });
                      },
                      child: Row(
                        children: [
                           Icon(
                                isFavorite
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: MyColors.primarycolor,
                                size: 40,
                              ),
                              Text(
                                isFavorite
                                    ? "Remove from your favourites"
                                    : "Add to your favourites",
                                style: GoogleFonts.leagueSpartan(
                                  fontSize: 20,
                                  color: MyColors.primarycolor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        ],
                      ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "About the recipe",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight:FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recipeDetails,
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Ingredients",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ingredients,
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Instructions",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    instructions,
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 20, color: MyColors.mainblack,),
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