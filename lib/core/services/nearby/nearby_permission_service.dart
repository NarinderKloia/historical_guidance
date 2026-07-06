import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class NearbyPermissionService {
  NearbyPermissionService._();

  static final NearbyPermissionService instance = NearbyPermissionService._();

  Future<bool> requestPermissions() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final permissions = <Permission>[
      Permission.location,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
    ];

    final result = await permissions.request();

    return result.values.every((status) => status.isGranted);
  }

  Future<bool> hasPermissions() async {
    if (!Platform.isAndroid) {
      return true;
    }

    return await Permission.location.isGranted &&
        await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothAdvertise.isGranted &&
        await Permission.bluetoothConnect.isGranted;
  }
}
