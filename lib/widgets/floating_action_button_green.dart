import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const FloatingActionButtonGreen(
      {Key? key, required this.iconData, required this.onPressed});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
  // void onPressedFav() {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text("Agregaste a tus Favoritos"),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav",
      onPressed: widget.onPressed,
      child: Icon(widget.iconData),
    );
  }
}
