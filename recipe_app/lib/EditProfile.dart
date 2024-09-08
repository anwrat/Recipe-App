import 'package:flutter/material.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/textfield2.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'package:recipe_app/widgets/showdialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  final String username;

  const EditProfile({required this.username, super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String prevpfp='';
  String prevbio='';
  final TextEditingController _pfpimage = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  bool isLoading = true;

  // Function to fetch current profile data
  Future<void> fetchProfileData() async {
    final url = Uri.parse('http://localhost:3000/api/getuserdetails');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': widget.username}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body); 
        if (data.isNotEmpty && data.first is Map<String, dynamic>){
          final user = data.first as Map<String, dynamic>;
          setState(() {
            _bio.text=user['bio'].toString();
            prevbio = user['bio'].toString();
            prevpfp=user['pfp'].toString();
            isLoading = false;
          });
        }
      } else {
        print('Failed to fetch profile: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching profile: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to send edited data to Node.js backend
  Future<void> sendData(BuildContext context, String username, String pfp, String bio) async {
    final url = Uri.parse('http://localhost:3000/api/editprofile');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'pfp': pfp,
        'bio': bio,
      }),
    );

    if (response.statusCode == 200) {
      await showErrorDialog(context, "Profile Edited successfully!!");
      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(username: username),
        ),
      );
    } else {
      print('Failed to change profile: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch existing profile data when the screen loads
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
                          "Profile Picture",
                          style: GoogleFonts.leagueSpartan(
                              fontSize: 30,
                              color: MyColors.mainblack,
                              fontWeight: FontWeight.bold),
                        ),
                        Textfields(
                          controller: _pfpimage,
                          displaytext: 'Add URL to the image...',
                          icons: 0xf60b,
                        ),
                        Text(
                          "Bio",
                          style: GoogleFonts.leagueSpartan(
                              fontSize: 30,
                              color: MyColors.mainblack,
                              fontWeight: FontWeight.bold),
                        ),
                        Textfields2(
                          controller: _bio,
                          displaytext: 'Description...',
                          icons: 0xe1bf,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Buttons(
                            title: "Confirm",
                            onPressed: () {
                              sendData(
                                context,
                                widget.username,
                                _pfpimage.text.isEmpty
                                    ? prevpfp
                                    : _pfpimage.text,
                                _bio.text,
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
