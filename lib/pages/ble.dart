import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_dart/meshcore_dart.dart';
import 'package:universal_ble/universal_ble.dart';
import 'package:freedomcore/utils/global_keys.dart';
import 'package:freedomcore/utils/snackbar_helper.dart';
import 'package:freedomcore/providers/meshcode_provider.dart';

extension IntToString on int {
  String toHex() => '0x${toRadixString(16)}';
  String toPadded([int width = 3]) => toString().padLeft(width, '0');
}

class BlePage extends ConsumerWidget {
  BlePage({Key? key}) : super(key: key);
  
  void scan(WidgetRef ref) async {
    final _isScanning = ref.read(isScanningProvider.notifier);
    final _deviceList = ref.read(DeviceListProvider.notifier);

    _deviceList.state = [];
    _isScanning.state = false;

    try {
      // Optionally show loading state

      if(Platform.isAndroid){
        Map<Permission, PermissionStatus> statuses = await [
            Permission.bluetoothScan,   // For scanning
            Permission.bluetoothConnect, // For connecting/pairing
            // Permission.bluetoothAdvertise, // If advertising
            // Permission.location, // Only if targeting older Android or if neverForLocation flag is omitted
          ].request();
        // Check statuses
        if (!statuses[Permission.bluetoothScan]!.isGranted ||
            !statuses[Permission.bluetoothConnect]!.isGranted) {
          // Handle denial (e.g., show explanation, open settings)
          throw Exception('Bluetooth permission not granted');
        }
      }

      _isScanning.state = true;

      final devices = await BleConnection.scan(
        timeout: const Duration(seconds: 3), // recommended: longer than 5s for reliable discovery
      );

      _deviceList.state = devices;
      _isScanning.state = false;

    } catch (e) {
      showSnackBar('Scan failed: $e', isError: true);
    }
  }
  
Future<void> _connect(BleDevice device, WidgetRef ref) async {
  final MCConnection = ref.read(BleConnectionProvider.notifier).state;
  // Prevent multiple connections or connecting while already connecting
  if (MCConnection?.isConnected ?? false) {
    print('Already connected to ${MCConnection?.deviceId}');
    return;
  }

  ref.read(isConnectingProvider.notifier).state = true;
  ref.read(isConnectedProvider.notifier).state = false;

  try {
    // Create the connection 
    ref.read(DeviceID.notifier).state = device.deviceId;
    final _MMConnection = BleConnection(device.deviceId);

    // Attempt to connect (with optional timeout)
    await _MMConnection.connect().timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw TimeoutException('Connection timed out');
      },
    );

    final regex = RegExp(r'MeshCore-([\w\d]+)');
    final match = regex.firstMatch(device.name ?? 'Non');

    ref.read(DeviceName.notifier).state = match?.group(1) ?? device.deviceId;
    ref.read(BleConnectionProvider.notifier).state = _MMConnection;
    ref.read(isConnectingProvider.notifier).state = false;
    ref.read(isConnectedProvider.notifier).state = true;
    showSnackBar('Connected to ${ref.read(DeviceName)}');

  } catch (e) {
    // Handle any connection error

    showSnackBar('Failed to connect: $e', isError: true);

    // Clean up failed connection
    await MCConnection?.close();
    ref.read(isConnectingProvider.notifier).state = false;
    ref.read(isConnectedProvider.notifier).state = false;
    }
}

Future<void> _disconnect(WidgetRef ref) async {
  try {
    final MCConnection = ref.read(BleConnectionProvider.notifier).state;
    if (MCConnection == null || !MCConnection.isConnected) {
      print('No active connection to disconnect.');
      return;
    }
    await MCConnection.close();
  } finally {
      ref.read(isScanningProvider.notifier).state = false;
      ref.read(isConnectingProvider.notifier).state = false;
      ref.read(isConnectedProvider.notifier).state = false;
  }
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _deviceList = ref.watch(DeviceListProvider);
    final _deviceName = ref.watch(DeviceName);
    final _isScanning = ref.watch(isScanningProvider);
    final _isConnecting = ref.watch(isConnectingProvider);
    final _isConnected = ref.watch(isConnectedProvider);

    return Scaffold(
          appBar: AppBar(
            title: ListTile(
              title: Text("OSMCore", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle:  _isConnected ? Text('Connected: ${_deviceName}') : Text('Available companions'),
              trailing: _isConnecting
                ? CircularProgressIndicator()
                : _isConnected
                  ? TextButton.icon(
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
                      icon: Icon(Icons.bluetooth_disabled),
                      label: Text('Disconnect'),
                      onPressed: () => _disconnect(ref),
                    ) : null
            ),
          ),
          body: _isScanning ?
            Center(child: CircularProgressIndicator())
            : _deviceList.isEmpty ?
            Center(child: Text('No devices found. Please ensure your companion device is on and advertising.'))
            : 
            Scrollbar(
            child: ListView(
              children: [
                for (final device in _deviceList)
                  Builder(builder: (context) {
                    return ElevatedButton(
                      child: Text("${device.name} rssi: ${device.rssi}"),
                      onPressed: () async {await _connect(device, ref);},
                    );
                  }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () => scan(ref),
          ),
    );
  }
}

class CardListTile extends StatelessWidget {
  final String name;
  final String? value;

  CardListTile(this.name, this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}