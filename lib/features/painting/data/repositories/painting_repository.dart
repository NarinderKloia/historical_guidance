import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/painting_model.dart';

class PaintingRepository {
  PaintingRepository._();

  static final PaintingRepository instance = PaintingRepository._();

  Future<Database> get _db async => DatabaseService.instance.database;

  // ==========================================================
  // Insert
  // ==========================================================

  Future<int> insertPainting(PaintingModel painting) async {
    final db = await _db;

    if (painting.beaconId != null) {
      final exists = await isBeaconAssigned(beaconId: painting.beaconId!);

      if (exists) {
        throw Exception("This beacon is already assigned to another painting.");
      }
    }

    return db.insert(DatabaseConstants.paintingTable, painting.toMap());
  }

  // ==========================================================
  // Update
  // ==========================================================

  Future<int> updatePainting(PaintingModel painting) async {
    final db = await _db;

    if (painting.id == null) {
      throw Exception("Painting id cannot be null.");
    }

    if (painting.beaconId != null) {
      final duplicate = await db.query(
        DatabaseConstants.paintingTable,
        where:
            '${DatabaseConstants.beaconId} = ? AND ${DatabaseConstants.id} != ?',
        whereArgs: [painting.beaconId, painting.id],
      );

      if (duplicate.isNotEmpty) {
        throw Exception("This beacon is already assigned.");
      }
    }

    return db.update(
      DatabaseConstants.paintingTable,
      painting.toMap(),
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [painting.id],
    );
  }

  // ==========================================================
  // Get By ID
  // ==========================================================

  Future<PaintingModel?> getPaintingById(int id) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.paintingTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return PaintingModel.fromMap(result.first);
  }

  // ==========================================================
  // Get By Gallery
  // ==========================================================

  Future<List<PaintingModel>> getPaintingsByGallery(int galleryId) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.paintingTable,
      where: '${DatabaseConstants.galleryId} = ?',
      whereArgs: [galleryId],
      orderBy: DatabaseConstants.title,
    );

    return result.map((map) => PaintingModel.fromMap(map)).toList();
  }

  // ==========================================================
  // Get All
  // ==========================================================

  Future<List<PaintingModel>> getAllPaintings() async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.paintingTable,
      orderBy: DatabaseConstants.title,
    );

    return result.map((map) => PaintingModel.fromMap(map)).toList();
  }

  // ==========================================================
  // Check Beacon Assignment
  // ==========================================================

  Future<bool> isBeaconAssigned({required int beaconId}) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.paintingTable,
      columns: [DatabaseConstants.id],
      where: '${DatabaseConstants.beaconId} = ?',
      whereArgs: [beaconId],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  // ==========================================================
  // Delete
  // ==========================================================

  Future<int> deletePainting(int id) async {
    final db = await _db;

    return db.delete(
      DatabaseConstants.paintingTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );
  }
}
