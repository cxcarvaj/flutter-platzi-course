import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platzi_trips_app/Place/ui/screens/add_place_screen.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'circle_button.dart';

class ButtonsBar extends StatelessWidget {
  late UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            // CircleButton(true, Icons.turned_in_not, 20.0,
            //     Color.fromRGBO(255, 255, 255, 1)),

            // Cambiar la contraseña
            CircleButton(true, Icons.vpn_key, 20.0,
                Color.fromRGBO(255, 255, 255, 0.6), (() => {})),

            // Añadir un nuevo lugar
            CircleButton(
                false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1), () {
              //File image;
              ImagePicker _picker = ImagePicker();
              _picker
                  .pickImage(
                      source: ImageSource.camera,
                      maxHeight: 720.0,
                      maxWidth: 1280.0,
                      imageQuality: 60)
                  .then((image) {
                if (image != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AddPlaceScreen(image: File(image.path))));
                } else {
                  print("No se tomó ninguna foto");
                }
              }).catchError((onError) {
                print("Error al tomar la foto: $onError");
              });
            }),

            // Cerrar Sesión
            CircleButton(
                true,
                Icons.exit_to_app,
                20.0,
                Color.fromRGBO(255, 255, 255, 0.6),
                (() => {
                      userBloc.signOut(),
                    })),
            // CircleButton(
            //     true, Icons.person, 20.0, Color.fromRGBO(255, 255, 255, 0.6))
          ],
        ));
  }
}
