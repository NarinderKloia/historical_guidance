import 'dart:io';

import 'package:historical_guidance/core/database/database_constants.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'nearby_constants.dart';

class NearbyReceiverService {
  NearbyReceiverService._();

  static final NearbyReceiverService instance = NearbyReceiverService._();

  final Nearby _nearby = Nearby();

  Future<void> startDiscovery({required String deviceName}) async {
    await _nearby.startDiscovery(
      deviceName,
      NearbyConstants.strategy,
      onEndpointFound: (id, name, serviceId) {
        print("Found endpoint:");
        print("ID: $id");
        print("Name: $name");

        _nearby.requestConnection(
          deviceName,
          id,
          onConnectionInitiated: _onConnectionInitiated,
          onConnectionResult: _onConnectionResult,
          onDisconnected: _onDisconnected,
        );
      },
      onEndpointLost: (id) {
        print("Endpoint lost: $id");
      },
    );
  }

  // ==========================================================
  // Connection Initiated
  // ==========================================================

  void _onConnectionInitiated(
    String endpointId,
    ConnectionInfo connectionInfo,
  ) {
    print("Connection initiated");

    _nearby.acceptConnection(
      endpointId,
      onPayLoadRecieved: _onPayloadReceived,
      onPayloadTransferUpdate: _onTransferUpdate,
    );
  }

  // ==========================================================
  // Connected
  // ==========================================================

  void _onConnectionResult(String endpointId, Status status) {
    print("Connection Result: $status");
  }

  // ==========================================================
  // Disconnected
  // ==========================================================

  void _onDisconnected(String endpointId) {
    print("Disconnected");
  }

  // ==========================================================
  // Payload Received
  // ==========================================================

  Future<void> _onPayloadReceived(String endpointId, Payload payload) async {
    if (payload.type != PayloadType.FILE) {
      return;
    }

    final receivedFile = File(payload.filePath!);

    final databasePath = await getDatabasesPath();

    final destination = File(
      join(databasePath, DatabaseConstants.databaseName),
    );

    if (await destination.exists()) {
      await destination.delete();
    }

    await receivedFile.copy(destination.path);

    print("Database saved to:");
    print(destination.path);
  }

  // ==========================================================
  // Transfer Progress
  // ==========================================================

  void _onTransferUpdate(String endpointId, PayloadTransferUpdate update) {
    print("Transfer: ${update.bytesTransferred}/${update.totalBytes}");

    if (update.status == PayloadStatus.SUCCESS) {
      print("Database received successfully");
    }
  }

  Future<void> stopDiscovery() async {
    await _nearby.stopDiscovery();
  }
}
