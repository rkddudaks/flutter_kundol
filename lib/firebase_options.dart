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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDQaqvtmKXQIoF19E3hCDFTerzw4q6cBrY',
    appId: '1:55925831107:web:5cd346757821aec265f976',
    messagingSenderId: '55925831107',
    projectId: 'flutterkundol',
    authDomain: 'flutterkundol.firebaseapp.com',
    storageBucket: 'flutterkundol.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtU5wJgLdO2uD8TxRul5w4f9vdoLxIZU8',
    appId: '1:55925831107:android:7f853bbe5f98768e65f976',
    messagingSenderId: '55925831107',
    projectId: 'flutterkundol',
    storageBucket: 'flutterkundol.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVCm_Qj810XhxSPfaVIKriceMxUK_nvNY',
    appId: '1:55925831107:ios:93850581ea6fc29965f976',
    messagingSenderId: '55925831107',
    projectId: 'flutterkundol',
    storageBucket: 'flutterkundol.appspot.com',
    androidClientId: '55925831107-rqa2cfh5gqojr8shu6ii8ngqn2vilgfc.apps.googleusercontent.com',
    iosClientId: '55925831107-4ued6vbupggr22787b9vn4beo24m0ii8.apps.googleusercontent.com',
    iosBundleId: 'com.themescoder.flutterKundol',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVCm_Qj810XhxSPfaVIKriceMxUK_nvNY',
    appId: '1:55925831107:ios:93850581ea6fc29965f976',
    messagingSenderId: '55925831107',
    projectId: 'flutterkundol',
    storageBucket: 'flutterkundol.appspot.com',
    androidClientId: '55925831107-rqa2cfh5gqojr8shu6ii8ngqn2vilgfc.apps.googleusercontent.com',
    iosClientId: '55925831107-4ued6vbupggr22787b9vn4beo24m0ii8.apps.googleusercontent.com',
    iosBundleId: 'com.themescoder.flutterKundol',
  );
}
