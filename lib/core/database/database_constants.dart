class DatabaseConstants {
  DatabaseConstants._();

  // Database
  static const String databaseName = 'historical_guidance.db';
  static const int databaseVersion = 2;

  // Tables
  static const String beaconTable = 'beacon';
  static const String museumTable = 'museum';
  static const String paintingTable = 'painting';
  static const String galleryTable = 'gallery';
  static const String galleryId = 'galleryId';
  // Common Columns
  static const String id = 'id';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';

  // Gallery Columns
  static const String galleryName = 'galleryName';
  static const String floor = 'floor';
  static const String galleryDescription = 'galleryDescription';

  // Museum Columns
  static const String museumName = 'name';
  static const String city = 'city';
  static const String museumDescription = 'description';

  // Painting Columns
  static const String museumId = 'museumId';
  static const String beaconId = 'beaconId';

  static const String title = 'title';
  static const String artist = 'artist';
  static const String year = 'year';
  static const String paintingDescription = 'description';

  static const String imagePath = 'imagePath';
  static const String audioPath = 'audioPath';

  // Beacon Columns
  static const String uuid = 'uuid';
  static const String major = 'major';
  static const String minor = 'minor';
}
