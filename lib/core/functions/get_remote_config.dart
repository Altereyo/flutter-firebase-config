import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<FirebaseRemoteConfig> getFirebaseRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  // setting FirebaseRemoteConfig update params
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(seconds: 10),
  ));
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}