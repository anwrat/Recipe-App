import 'package:flutter/material.dart';
import 'package:recipe_app/EditProfile.dart';
import 'package:recipe_app/widgets/displayrecipe.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/widgets/recipecard.dart';

class ProfilePage extends StatefulWidget {

  final String username;

  const ProfilePage({required this.username,super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String pfp='';
  String email='';
  String bio='';
  List<dynamic> favourites = [];
  bool isLoading = true;

  List<Map<String, dynamic>> recipes = []; // List to hold fetched recipes

  // Function to fetch recipes from backend
  Future<void> fetchRecipes() async {
    final url = Uri.parse('http://localhost:3000/api/getallrecipe'); // Your backend endpoint
    try {
      final response =
          await http.post(url, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body); // Decode the JSON response
        setState(() {
          // Convert each recipe to a Map<String, dynamic>
          recipes = data.map((item) => item as Map<String, dynamic>).toList();
          isLoading = false; // Stop loading when data is fetched
        });
      } else {
        print('Failed to fetch recipes: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching recipes: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to send data to Node.js backend
  Future<void> getData(BuildContext context,String username) async {
    final url = Uri.parse('http://localhost:3000/api/getuserdetails'); 
    try{
      final response = await http.post(url,headers: {'Content-Type': 'application/json'},body: jsonEncode({'username': username}),);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        
        if (data.isNotEmpty && data.first is Map<String, dynamic>) {
          final user = data.first as Map<String, dynamic>;
          // Update state variables with fetched data
          setState(() {
            pfp=user['pfp'].toString();
            email=user['email'].toString();
            bio=(user['bio']?.isEmpty ?? true) ? "..." : user['bio'];// Storing '...' if user['bio'] is empty or null
            favourites = user['favourites'];
            isLoading = false;
          });
        }
      }
      else {
        print('Failed to fetch userdetails: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    }catch(error){
      print('Error fetching userdetails: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData(context, widget.username);
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,//to remove the back arrow
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
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              pfp, 
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
                          Column(
                            children: [
                              Text(
                                widget.username,
                                style: GoogleFonts.leagueSpartan(
                                fontSize: 30, color: MyColors.mainblack,
                                fontWeight: FontWeight.bold),
                              ),
                              Text(
                                email,
                                style: GoogleFonts.leagueSpartan(
                                fontSize: 15, color: MyColors.mainblack,),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap:(){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>EditProfile(username: widget.username,)));
                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.pencil,color: MyColors.primarycolor,size: 40,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "About",
                      style: GoogleFonts.leagueSpartan(
                      fontSize: 24, color: MyColors.mainblack,
                      fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      bio,
                      style: GoogleFonts.leagueSpartan(
                      fontSize: 24, color: MyColors.mainblack,),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Created Recipes",
                      style: GoogleFonts.leagueSpartan(
                      fontSize: 24, color: MyColors.mainblack,
                      fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200, // Height of the recipe card section
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : recipes.isEmpty
                              ? Center(child: Text('No recipes found'))
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: recipes.length,
                                  itemBuilder: (context, index) {
                                    final recipe = recipes[index];
                                    final image = recipe['image'] ;
                                    final name = recipe['recipename'] ;
                                    final ownerUsername = recipe['owner'];

                                  // Check if the current user is the owner of the recipe
                                    if (ownerUsername != widget.username) {
                                      // If the current user is not the owner, skip this recipe
                                      return SizedBox.shrink(); // Empty space; won't render the card
                                    }
                                    return Container(
                                      width: MediaQuery.of(context).size.width /
                                          3, // Display 3 cards at a time
                                      height: 50,
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap:(){
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Displayrecipe(username: widget.username,recipename: name,)));
                                          },
                                        child: Recipecard(
                                          image: image,
                                          name: name,
                                        ),
                                      ),
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
      ),
    );
  }
}