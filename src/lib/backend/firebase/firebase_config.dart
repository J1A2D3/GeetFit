import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBJfByMH7u0J-ytmhgBiwkE6G2yHsKToRA",
            authDomain: "geet-fit-8oj3z6.firebaseapp.com",
            projectId: "geet-fit-8oj3z6",
            storageBucket: "geet-fit-8oj3z6.firebasestorage.app",
            messagingSenderId: "474957155325",
            appId: "1:474957155325:web:230f760c3afec5e87fa794",
            measurementId: "G-GT6WLHX7BN"));
  } else {
    await Firebase.initializeApp();
  }
}
