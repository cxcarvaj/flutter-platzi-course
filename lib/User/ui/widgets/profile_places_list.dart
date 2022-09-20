import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/bloc/bloc_user.dart';
import 'package:platzi_trips_app/User/model/user.dart';
import 'profile_place.dart';
import 'package:platzi_trips_app/Place/model/place.dart';

class ProfilePlacesList extends StatelessWidget {
  UserModel user;
  late UserBloc userBloc;

  ProfilePlacesList({Key? key, required this.user});

  // Place place = Place(
  //   name: "Knuckles Mountains Range",
  //   description: "Hiking. Water fall hunting. Natural bath",
  //   urlImage:
  //       "https://images.unsplash.com/photo-1519681393784-d120267933ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
  //   likes: 3,
  // );
  // Place place2 = Place(
  //     name: "Mountains",
  //     description:
  //         "Hiking. Water fall hunting. Natural bath', 'Scenery & Photography",
  //     urlImage:
  //         "https://images.unsplash.com/photo-1524654458049-e36be0721fa2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
  //     likes: 10);

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of<UserBloc>(context);
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: StreamBuilder(
          stream: userBloc.myPlacesListStream(user.uid!),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Error al obtener el sanpshot de Places de CloudFirestore"),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.data!.docs.isNotEmpty) {
                  return Column(
                    children: userBloc.buildMyPlaces(snapshot.data!.docs),
                  );
                } else {
                  print("Done: Snapshot: ${snapshot.data!.docs}");
                  return Center(
                      child: Text(
                          "Done: No tienes Places agregados aún, comienza agregando uno",
                          maxLines: 2,
                          textAlign: TextAlign.left));
                }
              case ConnectionState.active:
                if (snapshot.data!.docs.isNotEmpty) {
                  return Column(
                    children: userBloc.buildMyPlaces(snapshot.data!.docs),
                  );
                } else {
                  print("Active: Snapshot: ${snapshot.data!.docs}");
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text("Agregaste a tus Favoritos"),
                  // ));
                  return Center(
                      child: Text(
                          "Active: No tienes Places agregados aún, comienza agregando uno",
                          maxLines: 2,
                          textAlign: TextAlign.left));
                }
              case ConnectionState.none:
                return CircularProgressIndicator();
              default:
                if (snapshot.data!.docs.isNotEmpty) {
                  return Column(
                    children: userBloc.buildMyPlaces(snapshot.data!.docs),
                  );
                } else {
                  print("None: Snapshot: ${snapshot.data!.docs}");
                  return Center(
                      child: Text(
                          "None: No tienes Places agregados aún, comienza agregando uno",
                          maxLines: 2,
                          textAlign: TextAlign.left));
                }
            }
          }
          // return Column(
          //   children: [
          //     ProfilePlace(place),
          //     ProfilePlace(place2),
          //   ],
          // );
          ),
    );
  }
}
