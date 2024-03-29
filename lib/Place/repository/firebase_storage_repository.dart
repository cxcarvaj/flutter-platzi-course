import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_storage_api.dart';

class FirebaseStorageRepository {
  final _firebaseStorageApi = FirebaStorageApi();

  Future<UploadTask> uploadFile(String path, File image) =>
      _firebaseStorageApi.uploadFile(path, image);
}
