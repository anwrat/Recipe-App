import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class Textfields extends StatefulWidget{
  final String displaytext;
  const Textfields(
    {super.key,
    required this.displaytext,
  });
  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.displaytext,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        ),
      ],
    );
  }
}