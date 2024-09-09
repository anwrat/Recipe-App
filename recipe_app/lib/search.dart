import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/widgets/showdialog.dart';

class SearchPage extends StatefulWidget {
  final String username;
  const SearchPage({required this.username,super.key});
  @override
  State<StatefulWidget> createState() =>  _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _searchtext = TextEditingController();

  List<dynamic> searchResults = [];
  bool isLoading = false;
  bool hasSearched = false; // Flag to track if a search has been performed

  Future<void> searchRecipes(String searchText) async {
    final url = Uri.parse('http://localhost:3000/api/searchrecipe');

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'searchText': searchText}),
      );

      if (response.statusCode == 200) {
        setState(() {
          searchResults = jsonDecode(response.body);
        });
      } else {
        print('No recipes found: ${response.statusCode}');
        setState(() {
          searchResults = [];
        });
      }
    } catch (error) {
      print('Error fetching search results: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,//height of appbar
        automaticallyImplyLeading: false,// remove back button
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
                            controller: _searchtext,
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
                            if (_searchtext.text.isNotEmpty) {
                              hasSearched=true;
                              searchRecipes(_searchtext.text);
                            }
                            else{
                              showErrorDialog(context, "Please enter something to search");
                            }
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  isLoading
                  ? CircularProgressIndicator()
                  : Expanded(
                      child:hasSearched
                      ?searchResults.isNotEmpty 
                     ?ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final recipe = searchResults[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    recipe['image'], 
                                    width: 100, 
                                    height: 100,
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
                                      recipe['recipename'],
                                      style: GoogleFonts.leagueSpartan(
                                      fontSize: 20, color: MyColors.mainblack,fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Uploaded by: "+recipe['owner'],
                                      style: GoogleFonts.leagueSpartan(
                                      fontSize: 10, color: MyColors.mainblack),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                      : Center(
                        child:Text(
                          "No Search results found",
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      : const SizedBox.shrink(), // Hide content before searching
                    ),
              ],
              ),
            ),
          ),
        ),
      );
  }
}