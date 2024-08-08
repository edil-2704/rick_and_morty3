// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
       return android;
       
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJsxPylXVB7tWEoPW83i-IEeqLDBjq5Ek',
    appId: '1:980492932072:ios:921fe14b974b343af00a5d',
    messagingSenderId: '980492932072',
    projectId: 'rick-n-morty-4c652',
    databaseURL: 'https://rick-n-morty-4c652-default-rtdb.firebaseio.com',
    storageBucket: 'rick-n-morty-4c652.appspot.com',
    iosBundleId: 'com.example.rickAndMorty',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJsxPylXVB7tWEoPW83i-IEeqLDBjq5Ek',
    appId: '1:980492932072:ios:921fe14b974b343af00a5d',
    messagingSenderId: '980492932072',
    projectId: 'rick-n-morty-4c652',
    databaseURL: 'https://rick-n-morty-4c652-default-rtdb.firebaseio.com',
    storageBucket: 'rick-n-morty-4c652.appspot.com',
  );
}
