import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfields extends StatefulWidget {
  final TextEditingController controller;
  final String displaytext;
  final bool? ispass; // Change from Bool? to bool?
  final int? icons;

  const Textfields({
    super.key,
    required this.controller,
    required this.displaytext,
    this.icons,
    this.ispass,
  });

  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  bool _isObscured = true; // To handle password visibility toggle

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.ispass == true ? _isObscured : false, // Check if ispass is true
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
              suffixIcon: widget.ispass == true
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: const Color.fromRGBO(126, 126, 126, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured; // Toggle obscureText state
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
