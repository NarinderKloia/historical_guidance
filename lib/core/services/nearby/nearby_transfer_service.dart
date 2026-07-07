import 'dart:io';

import 'package:nearby_connections/nearby_connections.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/database_constants.dart';

class NearbyTransferService {
  NearbyTransferService._();

  static final NearbyTransferService instance = NearbyTransferService._();

  final Nearby _nearby = Nearby();

  // ==========================================================
  // Send SQLite Database
  // ==========================================================

  Future<void> sendDatabase(String endpointId) async {
    final dbFile = await _databaseFile();

    if (!await dbFile.exists()) {
      throw Exception("Database not found at ${dbFile.path}");
    }

    await _nearby.sendFilePayload(endpointId, dbFile.path);
  }

  // ==========================================================
  // Get Database File
  // ==========================================================

  Future<File> _databaseFile() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, DatabaseConstants.databaseName);

    return File(path);
  }
}
