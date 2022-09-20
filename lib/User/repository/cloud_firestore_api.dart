import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Place/model/place.dart';
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
}
