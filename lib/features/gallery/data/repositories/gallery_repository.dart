import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/gallery_model.dart';

class GalleryRepository {
  GalleryRepository._();

  static final GalleryRepository instance = GalleryRepository._();

  Future<Database> get _db async => DatabaseService.instance.database;

  // ==========================================================
  // Insert Gallery
  // ==========================================================

  Future<int> insertGallery(GalleryModel gallery) async {
    final db = await _db;

    return await db.insert(DatabaseConstants.galleryTable, gallery.toMap());
  }

  // ==========================================================
  // Get Gallery By ID
  // ==========================================================

  Future<GalleryModel?> getGalleryById(int id) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.galleryTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return GalleryModel.fromMap(result.first);
  }

  // ==========================================================
  // Get Galleries Of Museum
  // ==========================================================

  Future<List<GalleryModel>> getGalleriesByMuseum(int museumId) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.galleryTable,
      where: '${DatabaseConstants.museumId} = ?',
      whereArgs: [museumId],
      orderBy: DatabaseConstants.galleryName,
    );

    return result.map((e) => GalleryModel.fromMap(e)).toList();
  }

  // ==========================================================
  // Update Gallery
  // ==========================================================

  Future<int> updateGallery(GalleryModel gallery) async {
    final db = await _db;

    return await db.update(
      DatabaseConstants.galleryTable,
      gallery.toMap(),
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [gallery.id],
    );
  }

  // ==========================================================
  // Delete Gallery
  // ==========================================================

  Future<int> deleteGallery(int id) async {
    final db = await _db;

    return await db.delete(
      DatabaseConstants.galleryTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );
  }
}
