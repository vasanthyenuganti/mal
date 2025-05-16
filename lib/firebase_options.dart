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
        return windows;
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
    apiKey: 'AIzaSyDRRbAi7oL4k2a1HgG55vUXuq1cWw3yCvk',
    appId: '1:1044625104839:web:f8135718b59a12a71b83e2',
    messagingSenderId: '1044625104839',
    projectId: 'manage-assets-and-liabil-265e4',
    authDomain: 'manage-assets-and-liabil-265e4.firebaseapp.com',
    storageBucket: 'manage-assets-and-liabil-265e4.firebasestorage.app',
    measurementId: 'G-HDP7ESKNV5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDx6Ol-mXtdDa_Fry0rOnFo0xfhxW9bkIY',
    appId: '1:1044625104839:android:0052fd9bf4d05de81b83e2',
    messagingSenderId: '1044625104839',
    projectId: 'manage-assets-and-liabil-265e4',
    storageBucket: 'manage-assets-and-liabil-265e4.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjjb3R1b3dI2w_7rKWmz3tWuJQ8fb2MrI',
    appId: '1:1044625104839:ios:d2158b99e1f3dd581b83e2',
    messagingSenderId: '1044625104839',
    projectId: 'manage-assets-and-liabil-265e4',
    storageBucket: 'manage-assets-and-liabil-265e4.firebasestorage.app',
    iosBundleId: 'com.vasanthyenuganti.mal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjjb3R1b3dI2w_7rKWmz3tWuJQ8fb2MrI',
    appId: '1:1044625104839:ios:d2158b99e1f3dd581b83e2',
    messagingSenderId: '1044625104839',
    projectId: 'manage-assets-and-liabil-265e4',
    storageBucket: 'manage-assets-and-liabil-265e4.firebasestorage.app',
    iosBundleId: 'com.vasanthyenuganti.mal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDRRbAi7oL4k2a1HgG55vUXuq1cWw3yCvk',
    appId: '1:1044625104839:web:42c60b27a6a91c1c1b83e2',
    messagingSenderId: '1044625104839',
    projectId: 'manage-assets-and-liabil-265e4',
    authDomain: 'manage-assets-and-liabil-265e4.firebaseapp.com',
    storageBucket: 'manage-assets-and-liabil-265e4.firebasestorage.app',
    measurementId: 'G-NZ0LBBQTDC',
  );

}