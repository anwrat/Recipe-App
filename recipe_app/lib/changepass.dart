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

class ChangePass extends StatelessWidget {

  final String username;
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _confirmnewpasswordController = TextEditingController();

  ChangePass({required this.username,super.key});

  // Function to send data to Node.js backend
  Future<void> sendData(BuildContext context,String username,String oldpass, String newpass) async {
    final url = Uri.parse('http://localhost:3000/api/changepass'); 
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username':username,
        'oldpassword': oldpass,
        'newpassword': newpass,
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
                    controller: _oldpasswordController,
                    displaytext: 'Enter old password...',
                    icons: 0xe3ae,
                    ispass: true,
                    ),
                  Textfields(
                    controller: _newpasswordController,
                    displaytext: 'Enter new password...',
                    icons: 0xe3ae,
                    ispass: true,
                    ),
                  Textfields(
                    controller: _confirmnewpasswordController,
                    displaytext: 'Repeat password...',
                    icons: 0xe3ae,
                    ispass: true,
                    ),
                  Align(
                    alignment: Alignment.center,
                    child: Buttons(
                      title: "Confirm",
                      onPressed: () {
                        if(_oldpasswordController.text.isEmpty || _confirmnewpasswordController.text.isEmpty||_confirmnewpasswordController.text.isEmpty){
                          showErrorDialog(context, "Please fill all the fields");
                        }
                        else{
                          if (_newpasswordController.text == _confirmnewpasswordController.text) {
                            RegExp passcheck=RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).{7,}$');
                            if(passcheck.hasMatch(_newpasswordController.text)){
                              sendData(context,username,_oldpasswordController.text, _confirmnewpasswordController.text);
                            }
                            else{
                              showErrorDialog(context, "Password does not meet criteria");
                            }
                          } else {
                            showErrorDialog(context, 'Passwords do not match');
                          }
                        }
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