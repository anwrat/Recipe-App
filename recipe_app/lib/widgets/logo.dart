import 'package:flutter/material.dart';

class LogoSection extends StatelessWidget{
  const LogoSection({super.key,required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width:200,
      height:100,
      fit: BoxFit.contain,);
  }
}