import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class Buttons extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final Widget? icons;

  const Buttons(
      {super.key,
      required this.title,
      required this.onPressed,
      this.buttonColor = MyColors.primarycolor,
      this.textColor = MyColors.mainwhite,
      this.icons,});

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    if (widget.icons != null) {
      return ElevatedButton.icon(
        onPressed: widget.onPressed,
        icon: widget.icons!,
        label: Text(
          widget.title,
          style: TextStyle(
            color: widget.textColor,
          ),
        ), // Text on the right
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          minimumSize: const Size(120, 50),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          minimumSize: const Size(120, 50),
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 25.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.textColor,
          ),
        ),
      );
    }
  }
}