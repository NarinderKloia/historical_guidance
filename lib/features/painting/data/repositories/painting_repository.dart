import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/painting_model.dart';

class PaintingRepository {
  PaintingRepository._();

  static final PaintingRepository instance = PaintingRepository._();

  Future<Database> get _db async => DatabaseService.instance.database;

  // ==========================================================
  // Insert Painting
  // ==========================================================

  Future<int> insertPainting(PaintingModel painting) async {
    final db = await _db;

    return await db.insert(DatabaseConstants.paintingTable, painting.toMap());
  }

  // ==========================================================
  // Get Painting By ID
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
  // Get Paintings By Gallery
  // ==========================================================

  Future<List<PaintingModel>> getPaintingsByGallery(int galleryId) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.paintingTable,
      where: '${DatabaseConstants.galleryId} = ?',
      whereArgs: [galleryId],
      orderBy: DatabaseConstants.title,
    );

    return result.map((e) => PaintingModel.fromMap(e)).toList();
  }

  // ==========================================================
  // Get Painting By Beacon ID
  // ==========================================================

  Future<PaintingModel?> getPaintingByBeaconId(int beaconId) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.paintingTable,
      where: 'beaconId = ?',
      whereArgs: [beaconId],
    );

    if (result.isEmpty) {
      return null;
    }

    return PaintingModel.fromMap(result.first);
  }

  // ==========================================================
  // Update Painting
  // ==========================================================

  Future<int> updatePainting(PaintingModel painting) async {
    final db = await _db;

    return await db.update(
      DatabaseConstants.paintingTable,
      painting.toMap(),
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [painting.id],
    );
  }

  // ==========================================================
  // Delete Painting
  // ==========================================================

  Future<int> deletePainting(int id) async {
    final db = await _db;

    return await db.delete(
      DatabaseConstants.paintingTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );
  }
}
