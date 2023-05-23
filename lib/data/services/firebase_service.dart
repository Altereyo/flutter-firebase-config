import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_firebase_config/firebase_options.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  bool connected = false;
  FirebaseRemoteConfig? _remoteConfig;

  Future<void> connect() async {
    if (!connected) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      connected = true;
    }
  }

  Future<FirebaseRemoteConfig?> getRemoteConfig() async {
    try {
      if (_remoteConfig == null) {
        _remoteConfig = FirebaseRemoteConfig.instance;

        // setting config update params
        await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 10),
        ));

        // activating values
        await _remoteConfig!.fetchAndActivate();
      }
      return _remoteConfig;
    } catch (err) {
      return null;
    }
  }
}
