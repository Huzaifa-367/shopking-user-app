// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-4XMghjzw3jIL-hd5TwrUPzMs_dBClm0',
    appId: '1:814493246737:android:5be70aa55755e4d09ad8b0',
    messagingSenderId: '814493246737',
    projectId: 'sahulat-shopping',
    storageBucket: 'sahulat-shopping.appspot.com',
  );

  /// IOS Needs Configue
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABoypBa2lw750AVUHjNg0Y7HXyqskrgc0',
    appId: '1:814493246737:ios:836ee2a148ab62701bc7f1',
    messagingSenderId: '814493246737',
    projectId: 'sahulat-shopping',
    storageBucket: 'sahulat-shopping.appspot.com',
    iosBundleId: 'com.sahulat.shopping',
  );
}
