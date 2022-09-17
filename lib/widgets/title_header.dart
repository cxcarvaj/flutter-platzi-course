import 'package:flutter/material.dart';

class TitleHeader extends StatelessWidget {
  final String title;

  TitleHeader({Key? key, required this.title});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Text(title,
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
            color: Colors.white));
  }
}
