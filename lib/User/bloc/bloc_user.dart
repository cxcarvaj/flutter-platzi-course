// bloc library:
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Place/model/place.dart';
import '../../Place/repository/firebase_storage_repository.dart';
import '../model/user.dart';
import '../repository/cloud_firestore_api.dart';
import '../repository/cloud_firestore_repository.dart';
import '../ui/widgets/profile_place.dart';
import 'package:platzi_trips_app/User/repository/cloud_firestore_api.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();
  // Flujo de datos -> Streams (StreamController)
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;
  Future<User?> currentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  // Casos de uso de la aplicación en este caso del objeto user
  // 1. SignIn a la aplicación con Google
  Future<UserCredential> signIn() {
    return _auth_repository.signInFirebase();
  }

  // 2. Registrar usuario en la FirestoreDB
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<void> updateUserPlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  Stream<QuerySnapshot> placesListStream = FirebaseFirestore.instance
      .collection(CloudFirestoreAPI().PLACES)
      .snapshots();

  Stream<QuerySnapshot> get placesStream => placesListStream;

  List<ProfilePlace> buildPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreRepository.buildPlaces(placesListSnapshot);

  Stream<QuerySnapshot> myPlacesListStream(String uid) => FirebaseFirestore
      .instance
      .collection(CloudFirestoreAPI().PLACES)
      .where("userOwner",
          isEqualTo: FirebaseFirestore.instance
              .doc("${CloudFirestoreAPI().USERS}/$uid"))
      .snapshots();

  final _firebaseStorageRepository = FirebaseStorageRepository();
  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageRepository.uploadFile(path, image);

  void signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
