import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  final connectivity = Connectivity();
  final connectivityResult = await (connectivity.checkConnectivity());
  var result = connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
  return result;
}
