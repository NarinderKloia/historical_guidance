import 'package:sqflite/sqflite.dart';

import '../../../../core/database/database_constants.dart';
import '../../../../core/database/database_service.dart';
import '../models/museum_model.dart';

class MuseumRepository {
  MuseumRepository._();

  static final MuseumRepository instance = MuseumRepository._();

  Future<Database> get _db async => DatabaseService.instance.database;

  // ==========================================================
  // Insert Museum
  // ==========================================================

  Future<int> insertMuseum(MuseumModel museum) async {
    final db = await _db;

    return await db.insert(DatabaseConstants.museumTable, museum.toMap());
  }

  // ==========================================================
  // Get Museum By ID
  // ==========================================================

  Future<MuseumModel?> getMuseumById(int id) async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.museumTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return null;
    }

    return MuseumModel.fromMap(result.first);
  }

  // ==========================================================
  // Get All Museums
  // ==========================================================

  Future<List<MuseumModel>> getAllMuseums() async {
    final db = await _db;

    final result = await db.query(
      DatabaseConstants.museumTable,
      orderBy: DatabaseConstants.museumName,
    );

    return result.map((e) => MuseumModel.fromMap(e)).toList();
  }

  // ==========================================================
  // Update Museum
  // ==========================================================

  Future<int> updateMuseum(MuseumModel museum) async {
    final db = await _db;

    return await db.update(
      DatabaseConstants.museumTable,
      museum.toMap(),
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [museum.id],
    );
  }

  // ==========================================================
  // Delete Museum
  // ==========================================================

  Future<int> deleteMuseum(int id) async {
    final db = await _db;

    return await db.delete(
      DatabaseConstants.museumTable,
      where: '${DatabaseConstants.id} = ?',
      whereArgs: [id],
    );
  }
}
