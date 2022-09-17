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

  Future<DocumentReference<Object?>> updatePlaceData(Place place) async {
    CollectionReference refPlaces = _firestoreDB.collection(PLACES);
    User currentUser = _auth.currentUser!;
    return await refPlaces.add({
      'name': place.name,
      'description': place.description,
      'likes': place.likes,
      'userOwner': "$USERS/${currentUser.uid}",
    });
  }
}
