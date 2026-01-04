import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:meshcore_dart/meshcore_dart.dart';
import 'package:OSMCore/providers/meshcode_provider.dart';
import 'package:OSMCore/utils/snackbar_helper.dart';
// import 'package:chat_template/providers/chat_provider.dart';
// import 'package:chat_template/screens/chat_screen.dart';


extension IntToString on int {
  String toHex() => '0x${toRadixString(16)}';
  String toPadded([int width = 3]) => toString().padLeft(width, '0');
}

class SerialConnectionPage extends ConsumerWidget {
  SerialConnectionPage({Key? key}) : super(key: key);


  void scanPorts(WidgetRef ref) async {
    ref.read(availablePortsProvider.notifier).state = LibSerialPortWrapper.listAvailablePorts();
  }

  void _connect(WidgetRef ref, String port)
  {
    try {
      setupSerialGetIt(port);
      var SerialCon = getIt<SerialConnection>();
      SerialCon.connect();
      showSnackBar('Connected to serial port: $port');
      ref.read(isConnectedProvider.notifier).state = true;
      ref.read(DeviceName.notifier).state = port;
    } catch (e) {
      showSnackBar('Failed to connect to serial port: $e', isError: true);
    }
  }

  void _disconnect(WidgetRef ref) {
    final _isConnected = ref.read(isConnectedProvider.notifier);
    var SerialCon = getIt<SerialConnection>();
    SerialCon.close();
    _isConnected.state = false;
    showSnackBar('Disconnected from serial port');
  } 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availablePorts = ref.watch(availablePortsProvider);
    final _isConnected = ref.watch(isConnectedProvider);
    final _deviceName = ref.watch(DeviceName);
    return Scaffold(
          appBar: AppBar(
            title: ListTile(
              title: Text("OSMCore", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle:  _isConnected ? Text('Connected: ${_deviceName}') : Text('Available companions'),
              trailing: _isConnected
                 ? TextButton.icon(
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
                      icon: Icon(Icons.bluetooth_disabled),
                      label: Text('Disconnect'),
                      onPressed: () => _disconnect(ref),
                    ) : null
            ),
          ),
        body: Scrollbar(
          child: ListView(
            children: [
              for (final address in availablePorts)
                Builder(builder: (context) {
                  return ElevatedButton(
                    child: Text(address),
                    onPressed: () { _connect(ref, address);},
                  );
                }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => scanPorts(ref),
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
        title: Text(value ?? 'N/A'),
        subtitle: Text(name),
      ),
    );
  }
}