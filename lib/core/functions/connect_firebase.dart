import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_config/firebase_options.dart';

Future<void> connectFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}