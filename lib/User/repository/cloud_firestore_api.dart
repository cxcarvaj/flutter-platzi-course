import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:platzi_trips_app/User/ui/widgets/profile_place.dart';

import '../../Place/model/place.dart';
import '../../Place/ui/widgets/card_image.dart';
import '../model/user.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String PLACES = "places";

  final FirebaseFirestore _firestoreDB = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(UserModel user) async {
    CollectionReference users = _firestoreDB.collection(USERS);
    DocumentReference ref = users.doc(user.uid);
    return await ref.set({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoURL': user.photoURL,
      'myPlaces': user.myPlaces,
      'myFavoritePlaces': user.myFavoritePlaces,
      'lastSignIn': DateTime.now()
    }, SetOptions(merge: true));
  }

  Future<void> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _firestoreDB.collection(PLACES);
    User currentUser = _auth.currentUser!;
    DocumentReference<Object?> newPlaceRef = await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'urlImage': place.urlImage,
      'userOwner': _firestoreDB.doc("$USERS/${currentUser.uid}"),
    });
    DocumentSnapshot<Object?> placeSnapshot = await newPlaceRef.get();
    String placeId = placeSnapshot.id; // ID del Place que se acaba de asignar
    DocumentReference<Object?> refUsers =
        _firestoreDB.collection(USERS).doc(currentUser.uid);
    refUsers.update({
      'myPlaces': FieldValue.arrayUnion([_firestoreDB.doc("$PLACES/$placeId")])
    });
  }

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      placesListSnapshot
          .map((p) => ProfilePlace(
                Place(
                  name: p.get('name'),
                  description: p.get('description'),
                  likes: p.get('likes'),
                  urlImage: p.get('urlImage'),
                ),
              ))
          .toList();

  List<CardImageWithFabIcon> buildPlaces(
      List<DocumentSnapshot> placesListSnapshot) {
    double width = 300.0;
    double height = 250.0;
    double marginLeft = 20.0;
    IconData iconData = Icons.favorite_border;

    return placesListSnapshot
        .map(
          (p) => CardImageWithFabIcon(
            pathImage: p.get('urlImage'),
            width: width,
            height: height,
            marginLeft: marginLeft,
            iconData: iconData,
            onPressedFabIcon: () => likePlace(p.id),
          ),
        )
        .toList();
  }

  Future<void> likePlace(String idPlace) async {
    _firestoreDB.runTransaction((transaction) async {
      DocumentSnapshot placeDS =
          await _firestoreDB.collection(this.PLACES).doc(idPlace).get();
      print(placeDS);
      transaction
          .update(placeDS.reference, {"likes": placeDS.get('likes') + 1});
    });
  }
}
