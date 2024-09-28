import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBLiq0YezsFcdDpHMb23FaaRfVRqhe7pp0',
    appId: '1:157357360649:android:84ab4bee1ea713c2421ad8',
    messagingSenderId: '157357360649',
    projectId: 'learnathon-ade58',
    authDomain: 'bbtinventory-3a234.firebaseapp.com',
    storageBucket: 'learnathon-ade58.appspot.com',
    measurementId: 'G-P54T0MHW73',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwOsgCRMY1uUbvzkwdrhAuvl-D081k7ZA',
    appId: '1:26092939674:android:32e1cd457749f92fa6b223',
    messagingSenderId: '26092939674',
    projectId: 'attendance-56511',
    storageBucket: 'attendance-56511.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwOsgCRMY1uUbvzkwdrhAuvl-D081k7ZA',
    appId: '1:26092939674:android:32e1cd457749f92fa6b223',
    messagingSenderId: '26092939674',
    projectId: 'attendance-56511',
    // databaseURL:
    //     'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'attendance-56511.appspot.com',
    androidClientId:
        '1007123014608-bltjn27vhll8th88e9rb3p7g8raqkap5.apps.googleusercontent.com',
    iosClientId:
        '1007123014608-ae62omug4vpfvf8322gr06eo0qu51k34.apps.googleusercontent.com',
    iosBundleId: 'com.bbtInventory.chemical',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
    appId: '1:561998596877:android:aa9a599b6b64401ea3fe44',
    messagingSenderId: '561998596877',
    projectId: 'baps-app-6ce98',
    // databaseURL:
    //     'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'bbtInventory-3a234.appspot.com',
    androidClientId:
        '406099696497-17qn06u8a0dc717u8ul7s49ampk13lul.apps.googleusercontent.com',
    iosClientId:
        '406099696497-134k3722m01rtrsklhf3b7k8sqa5r7in.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebase.auth.example',
  );
}
