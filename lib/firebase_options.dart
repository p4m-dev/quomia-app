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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAcOcVn-sYXGh7zaF8WgUl1EbQo64vxVLY',
    appId: '1:342382484845:web:fe6734cbfe197630568e64',
    messagingSenderId: '342382484845',
    projectId: 'quomia',
    authDomain: 'quomia.firebaseapp.com',
    storageBucket: 'quomia.appspot.com',
    measurementId: 'G-RQQKT411S6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGm9gfPXgT_qzk_BbMpl9HUIut3HgEN3s',
    appId: '1:342382484845:android:f64b4bc25e69d483568e64',
    messagingSenderId: '342382484845',
    projectId: 'quomia',
    storageBucket: 'quomia.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpwlUMCk-R678bESTJVbx9oo45yYkvQfA',
    appId: '1:342382484845:ios:63bfbdb777d726fc568e64',
    messagingSenderId: '342382484845',
    projectId: 'quomia',
    storageBucket: 'quomia.appspot.com',
    iosBundleId: 'com.quomia.app',
  );
}
