import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {

  final String username;

  const ProfilePage({required this.username,super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String image='';
  String owner='';
  String category='';
  String recipeDetails = '';
  String ingredients = '';
  String instructions = '';
  bool isLoading = true;

  // Function to send data to Node.js backend
  Future<void> getData(BuildContext context,String username) async {
    final url = Uri.parse('http://localhost:3000/api/getrecipe'); 
    try{
      final response = await http.post(url,headers: {'Content-Type': 'application/json'},body: jsonEncode({'username': username}),);

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

  @override
  void initState() {
    super.initState();
    getData(context, widget.username);
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
                  Text(
                    widget.username,
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 30, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Email address of user",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 30, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
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
                  Text(
                    "Created Recipes",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 30, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Favourite Recipes",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 30, color: MyColors.mainblack,
                    fontWeight: FontWeight.bold),
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