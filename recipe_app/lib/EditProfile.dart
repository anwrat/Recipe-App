import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/widgets/buttons.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/textfield2.dart';
import 'package:recipe_app/widgets/textfields.dart';
import 'package:recipe_app/widgets/showdialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/settings.dart';

class EditProfile extends StatelessWidget {

  final String username;
  final TextEditingController _pfpimage = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  EditProfile({required this.username,super.key});

  // Function to send data to Node.js backend
  Future<void> sendData(BuildContext context,String username,String pfp, String bio) async {
    final url = Uri.parse('http://localhost:3000/api/changepass'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username':username,
        'pfp': pfp,
        'bio': bio,
      }),
    );

    if (response.statusCode == 200) {
      await showErrorDialog(context, "Password Changed successfully!!");
      Navigator.pop(
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
                  Text(
                    "Profile Picture",
                    style: GoogleFonts.leagueSpartan(
                    fontSize: 30, color: MyColors.mainblack,
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
                    fontSize: 30, color: MyColors.mainblack,
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
                        if(_pfpimage.text.isEmpty || _bio.text.isEmpty){
                          if(_pfpimage.text.isEmpty && _bio.text.isEmpty){
                            sendData(context, username, "https://i.postimg.cc/k5VcfPG7/blankpfp.webp", "");
                          }
                          else{
                            if(_pfpimage.text.isEmpty){
                              sendData(context, username, "https://i.postimg.cc/k5VcfPG7/blankpfp.webp", _bio.text);
                            }
                            else{
                              sendData(context, username, _pfpimage.text,"");
                            }
                          }
                        }
                        else{
                          sendData(context,username,_pfpimage.text, _bio.text);
                        }
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