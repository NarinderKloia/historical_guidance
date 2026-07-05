import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/beacon_model.dart';

class BeaconRepository {
  BeaconRepository._();

  static final BeaconRepository instance = BeaconRepository._();

  Future<Database> get _db async => DatabaseService.instance.database;

  // ==========================================================
  // Insert Beacon
  // ==========================================================

  Future<int> insertBeacon(BeaconModel beacon) async {
    final db = await _db;

    return await db.insert(DatabaseConstants.beaconTable, beacon.toMap());
  }

  // ==========================================================
  // Get Beacon By ID
  // ==========================================================

  Future<BeaconModel?> getBeaconById(int id) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.beaconTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return BeaconModel.fromMap(result.first);
  }

  // ==========================================================
  // Get Beacon By UUID, Major and Minor
  // ==========================================================

  Future<BeaconModel?> getBeaconByIdentity({
    required String uuid,
    required int major,
    required int minor,
  }) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.beaconTable,
      where:
          '${DatabaseConstants.uuid} = ? AND '
          '${DatabaseConstants.major} = ? AND '
          '${DatabaseConstants.minor} = ?',
      whereArgs: [uuid, major, minor],
    );

    if (result.isEmpty) {
      return null;
    }

    return BeaconModel.fromMap(result.first);
  }

  // ==========================================================
  // Get All Beacons
  // ==========================================================

  Future<List<BeaconModel>> getAllBeacons() async {
    final db = await _db;

    final result = await db.query(DatabaseConstants.beaconTable);

    return result.map((e) => BeaconModel.fromMap(e)).toList();
  }

  // ==========================================================
  // Update Beacon
  // ==========================================================

  Future<int> updateBeacon(BeaconModel beacon) async {
    final db = await _db;

    return await db.update(
      DatabaseConstants.beaconTable,
      beacon.toMap(),
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [beacon.id],
    );
  }

  // ==========================================================
  // Delete Beacon
  // ==========================================================

  Future<int> deleteBeacon(int id) async {
    final db = await _db;

    return await db.delete(
      DatabaseConstants.beaconTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );
  }
}
