// bloc library:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Place/model/place.dart';
import '../model/user.dart';
import '../repository/cloud_firestore_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();
  // Flujo de datos -> Streams (StreamController)
  Stream<User?> streamFirebase = FirebaseAuth.instance.authStateChanges();
  Stream<User?> get authStatus => streamFirebase;

  // Casos de uso de la aplicación en este caso del objeto user
  // 1. SignIn a la aplicación con Google
  Future<UserCredential> signIn() {
    return _auth_repository.signInFirebase();
  }

  // 2. Registrar usuario en la FirestoreDB
  final _cloudFirestoreRepository = CloudFirestoreRepository();
  void updateUserData(UserModel user) =>
      _cloudFirestoreRepository.updateUserDataFirestore(user);

  Future<DocumentReference<Object?>> updateUserPlaceData(Place place) =>
      _cloudFirestoreRepository.updatePlaceData(place);

  void signOut() {
    _auth_repository.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
