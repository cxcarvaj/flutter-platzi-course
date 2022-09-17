import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/Place/ui/widgets/card_image.dart';
import 'package:platzi_trips_app/Place/ui/widgets/title_input_location.dart';
import 'package:platzi_trips_app/widgets/button_purple.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';
import 'package:platzi_trips_app/widgets/text_input.dart';
import 'package:platzi_trips_app/widgets/title_header.dart';

class AddPlaceScreen extends StatefulWidget {
  File image;

  AddPlaceScreen({Key? key, required this.image});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final _controllerTitlePlace = TextEditingController();
    final _controllerDescriptionPlace = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          GradientBack(height: 300),
          Row(
            //App Bar
            children: [
              Container(
                padding: EdgeInsets.only(top: 25, left: 5),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 45, left: 20, right: 10),
                  child: TitleHeader(title: "Add a new Place"),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 120, bottom: 20),
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CardImageWithFabIcon(
                        pathImage: "assets/img/sunset.jpeg",
                        // widget.image.path,
                        width: 350,
                        height: 250,
                        marginLeft: 0,
                        iconData: Icons.camera_alt_outlined,
                        onPressedFabIcon: () {}),
                  ), // Foto del paisaje
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: TextInput(
                      hintText: "Title",
                      inputType: null,
                      maxLines: 1,
                      controller: _controllerTitlePlace,
                    ),
                  ),
                  TextInput(
                    hintText: "Description",
                    inputType: TextInputType.multiline,
                    maxLines: 4,
                    controller: _controllerDescriptionPlace,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: TextInputLocation(
                        hintText: "Add Location",
                        controller: TextEditingController(),
                        iconData: Icons.location_on_outlined),
                  ),
                  Container(
                    width: 70,
                    child: ButtonPurple(buttonText: 'Add Place', onPressed: (){
                      // Steps:
                      // 1. Upload the image to firebase storage
                      // 2. Get the url of the image
                      // 3. Use Firebase Cloud Firestore to save the place
                      // 4. Place - title, descriptiopn, url, userOwner, likes
                    }),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
