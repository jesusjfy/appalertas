import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDZBIbSROeyWW_-oB13T7M8vWqV2gSZ20k',
    appId: '1:846386062249:android:e5767c1795f93e267b1ab8',
    messagingSenderId: '846386062249',
    projectId: 'fir-g8-5f03c',
    storageBucket: 'fir-g8-5f03c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXl_ayaGhcr4ti1JUJbi3hYZH8Y9vZERw',
    appId: '1:846386062249:ios:08feb99441ee92167b1ab8',
    messagingSenderId: '846386062249',
    projectId: 'fir-g8-5f03c',
    storageBucket: 'fir-g8-5f03c.appspot.com',
    androidClientId: '846386062249-gd6r2fvh7pvq21k77sc3j3pautht25u1.apps.googleusercontent.com',
    iosClientId: '846386062249-ba9eipdq6j172akukejg2temgr6ps94o.apps.googleusercontent.com',
    iosBundleId: 'pe.tecsup.appalertas',
  );
}