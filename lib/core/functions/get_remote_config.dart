import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<FirebaseRemoteConfig> getFirebaseRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  // setting FirebaseRemoteConfig update params
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  return remoteConfig;
}