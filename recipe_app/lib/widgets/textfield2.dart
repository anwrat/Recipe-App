import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfields2 extends StatefulWidget {
  final TextEditingController controller;
  final String displaytext;
  final int? icons;

  const Textfields2({
    super.key,
    required this.controller,
    required this.displaytext,
    this.icons,
  });

  @override
  State<Textfields2> createState() => _Textfields2State();
}

class _Textfields2State extends State<Textfields2> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(217, 217, 217, 1),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromRGBO(217, 217, 217, 1)),
                borderRadius: BorderRadius.vertical(),
              ),
              border: const OutlineInputBorder(),
              hintText: widget.displaytext,
              hintStyle: GoogleFonts.leagueSpartan(
                fontSize: 20,
                color: Color.fromRGBO(156, 163, 175, 1),
              ),
              prefixIcon: widget.icons != null
                  ? Icon(
                      IconData(widget.icons!, fontFamily: 'MaterialIcons'),
                      color: const Color.fromRGBO(126, 126, 126, 1),
                    )
                  : null,
            ),
            maxLines: null, 
            minLines: 10,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline, 
          ),
        ),
      ],
    );
  }
}
