import 'package:flutter/material.dart';
import 'package:recipe_app/createrecipe.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/displayrecipe.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/widgets/recipecard.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({required this.username, super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> recipes = []; // List to hold fetched recipes
  bool isLoading = true; // Loading state
  List <dynamic> fav=[];
  List<Map<String, dynamic>> favouriteRecipes = [];

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
            fetchFavoriteRecipes(fav);
          });
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

  Future<void> fetchFavoriteRecipes(List<dynamic> recipeNames) async {
    for (String recipeName in recipeNames) {
      await fetchRecipeDetails(recipeName);
    }
    setState(() {
      isLoading = false; // Update loading state once all favorites are fetched
    });
  }

  Future<void> fetchRecipeDetails(String recipename) async {
    final url = Uri.parse('http://localhost:3000/api/getrecipe');
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'recipename': recipename}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List<dynamic> && data.isNotEmpty) {
          // Assuming you want the first recipe from the list
          final recipe = data.first as Map<String, dynamic>;
          setState(() {
            favouriteRecipes.add(recipe); // Add the fetched recipe to the favorite list
          });
        }
      } else {
        print('Failed to fetch recipe details: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching recipe details: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // Fetch recipes when the page loads
    getuserdetails(context, widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200, //height of appbar
        automaticallyImplyLeading: false, //remove back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoSection(image: 'assets/images/mainlogo.png'),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Our Recipes",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                const SizedBox(height: 30),
                Text(
                  "Your Favourites",
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 200, // Height of the recipe card section
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : recipes.isEmpty
                          ? Center(child: Text('No favourites found'))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: favouriteRecipes.length,
                              itemBuilder: (context, index) {
                                final favrecipe = favouriteRecipes[index];
                                final favimage = favrecipe['image'] ;
                                final favname = favrecipe['recipename'] ;
                                return Container(
                                  width: MediaQuery.of(context).size.width /
                                      3, // Display 3 cards at a time
                                  height: 50,
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap:(){
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=>Displayrecipe(username: widget.username,recipename: favname,)));
                                      },
                                    child: Recipecard(
                                      image: favimage,
                                      name: favname,
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primarycolor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Createrecipe(
                username: widget.username,
              ),
            ),
          );
        },
        child: const Icon(
          color: Color(0xffFFFFFF),
          Icons.add,
        ),
      ),
    );
  }
}
