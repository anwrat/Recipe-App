import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';

showErrorDialog(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error',style: GoogleFonts.leagueSpartan(fontSize: 20,color: MyColors.primarycolor)),
          content: Text(message,style: GoogleFonts.leagueSpartan(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              child: Text('OK',style: GoogleFonts.leagueSpartan(fontSize: 20)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}
