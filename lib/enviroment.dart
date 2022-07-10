import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get androidApiKey {
    return dotenv.env['ANDROID_API_KEY'] ?? 'ANDROID_API_KEY not found';
  }

  static String get androidAppId {
    return dotenv.env['ANDROID_APP_ID'] ?? 'ANDROID_APP_ID not found';
  }

  static String get messagingSenderId {
    return dotenv.env['MESSAGING_SENDER_ID'] ?? 'MESSAGING_SENDER_ID not found';
  }

  static String get projectId {
    return dotenv.env['PROJECT_ID'] ?? 'PROJECT_ID not found';
  }

  static String get storageBucket {
    return dotenv.env['STORAGE_BUCKET'] ?? 'STORAGE_BUCKET not found';
  }

  static String get iosApiKey {
    return dotenv.env['IOS_API_KEY'] ?? 'IOS_API_KEY not found';
  }

  static String get iosAppId {
    return dotenv.env['IOS_APP_ID'] ?? 'IOS_APP_ID not found';
  }

  static String get iosClientId {
    return dotenv.env['IOS_CLIENT_ID'] ?? 'IOS_CLIENT_ID not found';
  }

  static String get iosBundleId {
    return dotenv.env['IOS_BUNDLE_ID'] ?? 'IOS_BUNDLE_ID not found';
  }
}
