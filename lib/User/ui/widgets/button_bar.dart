import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
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
                false, Icons.add, 40.0, Color.fromRGBO(255, 255, 255, 1), (() {
              File image = new File('assets/img/beach_palm.jpg');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPlaceScreen(image: image)));
            })),

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
