import '../../../../core/database/database_constants.dart';

class PaintingModel {
  final int? id;

  final int galleryId;

  /// Nullable because a beacon may be assigned later.
  final int? beaconId;

  final String title;
  final String artist;
  final String year;
  final String paintingDescription;

  /// Nullable because image may be added later.
  final String? imagePath;

  /// Nullable because audio may be added later.
  final String? audioPath;

  final String createdAt;
  final String updatedAt;

  const PaintingModel({
    this.id,
    required this.galleryId,
    this.beaconId,
    required this.title,
    required this.artist,
    required this.year,
    required this.paintingDescription,
    this.imagePath,
    this.audioPath,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.galleryId: galleryId,
      DatabaseConstants.beaconId: beaconId,
      DatabaseConstants.title: title,
      DatabaseConstants.artist: artist,
      DatabaseConstants.year: year,
      DatabaseConstants.paintingDescription: paintingDescription,
      DatabaseConstants.imagePath: imagePath,
      DatabaseConstants.audioPath: audioPath,
      DatabaseConstants.createdAt: createdAt,
      DatabaseConstants.updatedAt: updatedAt,
    };
  }

  factory PaintingModel.fromMap(Map<String, dynamic> map) {
    return PaintingModel(
      id: map[DatabaseConstants.id] as int?,
      galleryId: map[DatabaseConstants.galleryId] as int,
      beaconId: map[DatabaseConstants.beaconId] as int?,
      title: map[DatabaseConstants.title] as String,
      artist: map[DatabaseConstants.artist] as String,
      year: map[DatabaseConstants.year] as String,
      paintingDescription: map[DatabaseConstants.paintingDescription] as String,
      imagePath: map[DatabaseConstants.imagePath] as String?,
      audioPath: map[DatabaseConstants.audioPath] as String?,
      createdAt: map[DatabaseConstants.createdAt] as String,
      updatedAt: map[DatabaseConstants.updatedAt] as String,
    );
  }

  PaintingModel copyWith({
    int? id,
    int? galleryId,
    Object? beaconId = null,
    String? title,
    String? artist,
    String? year,
    String? paintingDescription,
    Object? imagePath = null,
    Object? audioPath = null,
    String? createdAt,
    String? updatedAt,
  }) {
    return PaintingModel(
      id: id ?? this.id,
      galleryId: galleryId ?? this.galleryId,
      beaconId: identical(beaconId, _noChange)
          ? this.beaconId
          : beaconId as int?,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      year: year ?? this.year,
      paintingDescription: paintingDescription ?? this.paintingDescription,
      imagePath: identical(imagePath, _noChange)
          ? this.imagePath
          : imagePath as String?,
      audioPath: identical(audioPath, _noChange)
          ? this.audioPath
          : audioPath as String?,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static final Object _noChange = Object();

  @override
  String toString() {
    return 'PaintingModel('
        'id: $id, '
        'title: $title, '
        'artist: $artist, '
        'galleryId: $galleryId, '
        'beaconId: $beaconId, '
        'imagePath: $imagePath, '
        'audioPath: $audioPath'
        ')';
  }
}
