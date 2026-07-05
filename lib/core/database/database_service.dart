import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DatabaseConstants.databaseName);

    // ==========================================================
    // DEVELOPMENT ONLY
    // Delete database every run while schema is under development.
    // REMOVE THIS LINE BEFORE RELEASE.
    // ==========================================================
    await deleteDatabase(path);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    // ==========================================================
    // MUSEUM TABLE
    // ==========================================================

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.museumTable} (
        ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,

        ${DatabaseConstants.museumName} TEXT NOT NULL,
        ${DatabaseConstants.city} TEXT NOT NULL,
        ${DatabaseConstants.museumDescription} TEXT NOT NULL,

        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        ${DatabaseConstants.updatedAt} TEXT NOT NULL
      )
    ''');

    // ==========================================================
    // GALLERY TABLE
    // ==========================================================

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.galleryTable} (
        ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,

        ${DatabaseConstants.museumId} INTEGER NOT NULL,

        ${DatabaseConstants.galleryName} TEXT NOT NULL,
        ${DatabaseConstants.floor} TEXT NOT NULL,
        ${DatabaseConstants.galleryDescription} TEXT NOT NULL,

        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        ${DatabaseConstants.updatedAt} TEXT NOT NULL,

        FOREIGN KEY (${DatabaseConstants.museumId})
            REFERENCES ${DatabaseConstants.museumTable}(${DatabaseConstants.id})
            ON DELETE CASCADE
      )
    ''');

    // ==========================================================
    // BEACON TABLE
    // ==========================================================

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.beaconTable} (
        ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,

        ${DatabaseConstants.uuid} TEXT NOT NULL,
        ${DatabaseConstants.major} INTEGER NOT NULL,
        ${DatabaseConstants.minor} INTEGER NOT NULL,

        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        ${DatabaseConstants.updatedAt} TEXT NOT NULL
      )
    ''');

    // ==========================================================
    // PAINTING TABLE
    // ==========================================================

    await db.execute('''
      CREATE TABLE ${DatabaseConstants.paintingTable} (
        ${DatabaseConstants.id} INTEGER PRIMARY KEY AUTOINCREMENT,

        ${DatabaseConstants.galleryId} INTEGER NOT NULL,
        ${DatabaseConstants.beaconId} INTEGER NOT NULL,

        ${DatabaseConstants.title} TEXT NOT NULL,
        ${DatabaseConstants.artist} TEXT NOT NULL,
        ${DatabaseConstants.year} TEXT NOT NULL,
        ${DatabaseConstants.paintingDescription} TEXT NOT NULL,

        ${DatabaseConstants.imagePath} TEXT NOT NULL,
        ${DatabaseConstants.audioPath} TEXT NOT NULL,

        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        ${DatabaseConstants.updatedAt} TEXT NOT NULL,

        FOREIGN KEY (${DatabaseConstants.galleryId})
            REFERENCES ${DatabaseConstants.galleryTable}(${DatabaseConstants.id})
            ON DELETE CASCADE,

        FOREIGN KEY (${DatabaseConstants.beaconId})
            REFERENCES ${DatabaseConstants.beaconTable}(${DatabaseConstants.id})
            ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migrations will go here.
  }
}
