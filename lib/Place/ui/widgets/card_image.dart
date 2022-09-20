import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platzi_trips_app/widgets/floating_action_button_green.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final double height;
  final double width;

  final double marginLeft;

  final String pathImage;

  final VoidCallback onPressedFabIcon;
  final IconData iconData;

  CardImageWithFabIcon(
      {Key? key,
      required this.pathImage,
      required this.width,
      required this.height,
      required this.onPressedFabIcon,
      required this.iconData,
      required this.marginLeft});

  @override
  Widget build(BuildContext context) {
    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: marginLeft),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: pictureValidation(pathImage),
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 15.0,
                offset: Offset(0.0, 7.0))
          ]),
    );

    return Stack(
      alignment: Alignment(0.9, 1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
          iconData: iconData,
          onPressed: onPressedFabIcon,
        )
      ],
    );
  }

  ImageProvider pictureValidation(String pathImage) {
    if (pathImage.contains('http')) {
      return NetworkImage(pathImage);
    } else if (pathImage.contains("assets")) {
      return AssetImage(pathImage);
    } else {
      return new FileImage(new File(pathImage));
    }
  }
}
