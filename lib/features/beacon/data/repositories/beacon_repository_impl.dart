import 'package:historical_guidance/features/beacon/data/repositories/beacon_repository.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/beacon_model.dart';

class BeaconRepositoryImpl implements BeaconRepository {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<int> insertBeacon(BeaconModel beacon) async {
    final Database db = await _databaseService.database;

    return await db.insert(DatabaseConstants.beaconTable, beacon.toMap());
  }

  @override
  Future<List<BeaconModel>> getAllBeacons() async {
    final Database db = await _databaseService.database;

    final List<Map<String, dynamic>> result = await db.query(
      DatabaseConstants.beaconTable,
    );

    return result.map((e) => BeaconModel.fromMap(e)).toList();
  }

  @override
  Future<BeaconModel?> getBeaconById(int id) async {
    final Database db = await _databaseService.database;

    final result = await db.query(
      DatabaseConstants.beaconTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return BeaconModel.fromMap(result.first);
  }

  @override
  Future<int> updateBeacon(BeaconModel beacon) async {
    final Database db = await _databaseService.database;

    return await db.update(
      DatabaseConstants.beaconTable,
      beacon.toMap(),
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [beacon.id],
    );
  }

  @override
  Future<int> deleteBeacon(int id) async {
    final Database db = await _databaseService.database;

    return await db.delete(
      DatabaseConstants.beaconTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<BeaconModel?> getBeaconByIdentity({
    required String uuid,
    required int major,
    required int minor,
  }) {
    // TODO: implement getBeaconByIdentity
    throw UnimplementedError();
  }

  @override
  Future<bool> beaconExists({
    required String uuid,
    required int major,
    required int minor,
  }) {
    // TODO: implement beaconExists
    throw UnimplementedError();
  }

  @override
  Future<List<BeaconModel>> getUnassignedBeacons() {
    // TODO: implement getUnassignedBeacons
    throw UnimplementedError();
  }

  @override
  Future<List<BeaconModel>> getAvailableBeaconsForPainting(
    int? currentBeaconId,
  ) {
    // TODO: implement getAvailableBeaconsForPainting
    throw UnimplementedError();
  }
}
