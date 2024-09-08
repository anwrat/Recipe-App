import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/colors.dart';

class Recipecard extends StatelessWidget{
  final String image;
  final String name;
  Recipecard({required this.image,required this.name,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            image, 
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
        Text(
          name,
          style: GoogleFonts.leagueSpartan(
          fontSize: 20, color: MyColors.mainblack,),
        ),
      ],
    );
  }
}