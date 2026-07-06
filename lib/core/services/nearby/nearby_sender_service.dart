import 'dart:async';

import 'package:nearby_connections/nearby_connections.dart';

import 'nearby_constants.dart';

class NearbySenderService {
  NearbySenderService._();

  static final NearbySenderService instance = NearbySenderService._();

  final Nearby _nearby = Nearby();

  final StreamController<String> _statusController =
      StreamController.broadcast();

  Stream<String> get statusStream => _statusController.stream;

  String? _connectedEndpointId;

  String? get connectedEndpointId => _connectedEndpointId;

  bool get isConnected => _connectedEndpointId != null;

  // ==========================================================
  // Start Advertising
  // ==========================================================

  Future<void> startAdvertising({required String deviceName}) async {
    _statusController.add("Starting advertising...");

    try {
      await _nearby.startAdvertising(
        deviceName,
        NearbyConstants.strategy,
        onConnectionInitiated: _onConnectionInitiated,
        onConnectionResult: _onConnectionResult,
        onDisconnected: _onDisconnected,
        serviceId: NearbyConstants.serviceId,
      );

      _statusController.add("Advertising started");
    } catch (e) {
      _statusController.add("Advertising failed");
      rethrow;
    }
  }

  // ==========================================================
  // Stop Advertising
  // ==========================================================

  Future<void> stopAdvertising() async {
    await _nearby.stopAdvertising();

    _statusController.add("Advertising stopped");
  }

  // ==========================================================
  // Connection Initiated
  // ==========================================================

  void _onConnectionInitiated(String endpointId, ConnectionInfo info) {
    _statusController.add("Connection request from ${info.endpointName}");

    _nearby.acceptConnection(
      endpointId,
      onPayLoadRecieved: (_, __) {},
      onPayloadTransferUpdate: (_, __) {},
    );
  }

  // ==========================================================
  // Connection Result
  // ==========================================================

  void _onConnectionResult(String endpointId, Status status) {
    if (status == Status.CONNECTED) {
      _connectedEndpointId = endpointId;

      _statusController.add("Receiver connected");
    } else {
      _statusController.add("Connection failed");
    }
  }

  // ==========================================================
  // Disconnected
  // ==========================================================

  void _onDisconnected(String endpointId) {
    _connectedEndpointId = null;

    _statusController.add("Receiver disconnected");
  }

  // ==========================================================
  // Dispose
  // ==========================================================

  void dispose() {
    _statusController.close();
  }
}
