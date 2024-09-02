import 'package:flutter/material.dart';

class Textfields extends StatefulWidget {
  final String displaytext;
  final bool? ispass; // Change from Bool? to bool?
  final int? icons;

  const Textfields({
    super.key,
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
