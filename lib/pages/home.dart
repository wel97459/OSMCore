import 'dart:io';

import 'package:freedomcore/utils/global_keys.dart';
import 'package:meshcore_dart/meshcore_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freedomcore/providers/meshcode_provider.dart';
import 'package:freedomcore/utils/snackbar_helper.dart';

class HomePage extends ConsumerWidget {

// Extracted method for better readability
  List<PopupMenuEntry<String>> _buildMenuItems(BuildContext context) {
    return [
      const PopupMenuItem<String>(
        value: 'disconnect',
        child: Row(
          children: [
            Icon(Icons.bluetooth_disabled),
            SizedBox(width: 8),
            Text('Disconnect'),
          ],
        ),
      ),
      const PopupMenuDivider(),
      const PopupMenuItem<String>(
        value: 'settings',
        child: Row(
          children: [
            Icon(Icons.settings),
            SizedBox(width: 8),
            Text('Settings'),
          ],
        ),
      ),
    ];
  }
  
  List<PopupMenuEntry<String>> _buildAdvertMenuItems(BuildContext context) {
    return [
      const PopupMenuItem<String>(
        value: 'advert0hop',
        child: Row(
          children: [
            Icon(Icons.connect_without_contact),
            SizedBox(width: 8),
            Text('Advert - Zero Hop'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'advertflood',
        child: Row(
          children: [
            Icon(Icons.cell_tower),
            SizedBox(width: 8),
            Text('Advert - Flood'),
          ],
        ),
      ),
      const PopupMenuItem<String>(
        value: 'advertclipboard',
        child: Row(
          children: [
            Icon(Icons.copy),
            SizedBox(width: 8),
            Text('Advert - To Clipboard'),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var MCConnection;
    if(Platform.isAndroid){
      MCConnection = ref.read(BleConnectionProvider);
    } else {
      MCConnection = ref.read(SerialConnectionProvider);
    }

    final MeshCoreDeviceName = ref.watch(DeviceName);
    final isConnected = ref.watch(isConnectedProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          title: Text('OSMCore', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          subtitle: Text(isConnected ? MeshCoreDeviceName : 'Disconnected', style: TextStyle(fontSize: 14)),
          trailing: isConnected ? Row(mainAxisSize: MainAxisSize.min, children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'advert0hop') {
                  try {
                    MCConnection?.sendAdvert(AdvType.chat);
                    showSnackBar('Advert sent via Zero Hop');
                  } catch (e) {
                    showSnackBar('Failed to send advert: $e', isError: true);
                  }
                } else if (value == 'advertflood') {
                  try {
                    MCConnection?.sendFloodAdvert();
                    showSnackBar('Advert sent via Flood');
                  } catch (e) {
                    showSnackBar('Failed to send advert: $e', isError: true);
                  }
                }
              },
              itemBuilder: (BuildContext context) => _buildAdvertMenuItems(context),
              icon: Icon(Icons.campaign),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'disconnect') {
                  MCConnection?.close();
                  ref.read(isConnectedProvider.notifier).state = false;
                  showSnackBar('Disconnected from ${MeshCoreDeviceName}');
                }
              },
              itemBuilder: (BuildContext context) => _buildMenuItems(context),
              icon: Icon(Icons.more_vert),
            )])
          :
            Platform.isAndroid ?
              TextButton.icon(
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
                icon: Icon(Icons.bluetooth),
                label: Text('Connect'),
                onPressed: () {Navigator.pushNamed(context, '/ble');}
              )
            :
              TextButton.icon(
                style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
                icon: Icon(Icons.cable),
                label: Text('Connect'),
                onPressed: () {Navigator.pushNamed(context, '/serial');}
              )
        ),
      ),
      body: Center(
        child: Text('Nothing to see here yet!'),
      ),
    );
  }
}

