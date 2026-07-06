import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/beacon_model.dart';

class BeaconRepository {
  BeaconRepository._();

  static final BeaconRepository instance = BeaconRepository._();

  Future<Database> get _db async => DatabaseService.instance.database;

  // ==========================================================
  // Insert
  // ==========================================================

  Future<int> insertBeacon(BeaconModel beacon) async {
    final exists = await beaconExists(
      uuid: beacon.uuid,
      major: beacon.major,
      minor: beacon.minor,
    );

    if (exists) {
      throw Exception("Beacon already exists.");
    }

    final db = await _db;

    return db.insert(DatabaseConstants.beaconTable, beacon.toMap());
  }

  // ==========================================================
  // Get All
  // ==========================================================

  Future<List<BeaconModel>> getAllBeacons() async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.beaconTable,
      orderBy: DatabaseConstants.major,
    );

    return result.map(BeaconModel.fromMap).toList();
  }

  // ==========================================================
  // Get By ID
  // ==========================================================

  Future<BeaconModel?> getBeaconById(int id) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.beaconTable,
      where: '${DatabaseConstants.id}=?',
      whereArgs: [id],
    );

    if (result.isEmpty) return null;

    return BeaconModel.fromMap(result.first);
  }

  // ==========================================================
  // Get By Identity
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
          '${DatabaseConstants.uuid}=? AND ${DatabaseConstants.major}=? AND ${DatabaseConstants.minor}=?',
      whereArgs: [uuid, major, minor],
    );

    if (result.isEmpty) return null;

    return BeaconModel.fromMap(result.first);
  }

  // ==========================================================
  // Exists
  // ==========================================================

  Future<bool> beaconExists({
    required String uuid,
    required int major,
    required int minor,
  }) async {
    return await getBeaconByIdentity(uuid: uuid, major: major, minor: minor) !=
        null;
  }

  // ==========================================================
  // Update
  // ==========================================================

  Future<int> updateBeacon(BeaconModel beacon) async {
    final db = await _db;

    final duplicate = await db.query(
      DatabaseConstants.beaconTable,
      where:
          '${DatabaseConstants.uuid}=? AND '
          '${DatabaseConstants.major}=? AND '
          '${DatabaseConstants.minor}=? AND '
          '${DatabaseConstants.id} != ?',
      whereArgs: [beacon.uuid, beacon.major, beacon.minor, beacon.id],
    );

    if (duplicate.isNotEmpty) {
      throw Exception("Beacon already exists.");
    }

    return db.update(
      DatabaseConstants.beaconTable,
      beacon.toMap(),
      where: '${DatabaseConstants.id}=?',
      whereArgs: [beacon.id],
    );
  }

  // ==========================================================
  // Delete
  // ==========================================================

  Future<int> deleteBeacon(int id) async {
    final db = await _db;

    return db.delete(
      DatabaseConstants.beaconTable,
      where: '${DatabaseConstants.id}=?',
      whereArgs: [id],
    );
  }

  Future<List<BeaconModel>> getUnassignedBeacons() async {
    final db = await _db;

    final result = await db.rawQuery('''
    SELECT *
    FROM ${DatabaseConstants.beaconTable}
    WHERE ${DatabaseConstants.id} NOT IN (
      SELECT ${DatabaseConstants.beaconId}
      FROM ${DatabaseConstants.paintingTable}
    )
    ORDER BY ${DatabaseConstants.major},
             ${DatabaseConstants.minor}
  ''');

    return result.map(BeaconModel.fromMap).toList();
  }

  Future<List<BeaconModel>> getAvailableBeaconsForPainting(
    int? currentBeaconId,
  ) async {
    final db = await _db;

    final result = await db.rawQuery(
      '''
    SELECT *
    FROM ${DatabaseConstants.beaconTable}
    WHERE ${DatabaseConstants.id} = ?
       OR ${DatabaseConstants.id} NOT IN (
          SELECT ${DatabaseConstants.beaconId}
          FROM ${DatabaseConstants.paintingTable}
          WHERE ${DatabaseConstants.beaconId} IS NOT NULL
       )
    ORDER BY ${DatabaseConstants.major},
             ${DatabaseConstants.minor}
  ''',
      [currentBeaconId],
    );

    return result.map(BeaconModel.fromMap).toList();
  }
}
