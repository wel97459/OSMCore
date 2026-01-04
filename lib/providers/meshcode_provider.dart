import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meshcore_dart/meshcore_dart.dart';
import 'package:universal_ble/universal_ble.dart';
import 'package:get_it/get_it.dart';

//part 'meshcore_provider.g.dart';

// Is scanning?
final isScanningProvider = StateProvider<bool>((ref) {
  return false;
});

final isConnectingProvider = StateProvider<bool>((ref) {
  return false;
});

final isConnectedProvider = StateProvider<bool>((ref) {
  return false;
});

final availablePortsProvider = StateProvider<List<String>>((ref) {
  return [];
});

final DeviceListProvider = StateProvider<List<BleDevice>>((ref) {
  return [];
}); 

final DeviceID = StateProvider<String>((ref) {
  return '';
});

final DeviceName = StateProvider<String>((ref) {
  return '';
}); 

final ContactsProvider = StateProvider<List<dynamic>>((ref) {
  return [];
}); 

final getIt = GetIt.instance;

void setupSerialGetIt(String port) {
  try {
    getIt<SerialConnection>().close();
    getIt.unregister<SerialConnection>();
  } catch (e) {
    // Handle error if needed
  }
  getIt.registerLazySingleton<SerialConnection>(() => SerialConnection(LibSerialPortPlusWrapper(port, 115200)));
}