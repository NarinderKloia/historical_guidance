import '../../../../core/database/database_constants.dart';

class PaintingModel {
  final int? id;

  final int galleryId;
  final int beaconId;

  final String title;
  final String artist;
  final String year;
  final String paintingDescription;

  final String imagePath;
  final String audioPath;

  final String createdAt;
  final String updatedAt;

  const PaintingModel({
    this.id,
    required this.galleryId,
    required this.beaconId,
    required this.title,
    required this.artist,
    required this.year,
    required this.paintingDescription,
    required this.imagePath,
    required this.audioPath,
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
      id: map[DatabaseConstants.id],
      galleryId: map[DatabaseConstants.galleryId],
      beaconId: map[DatabaseConstants.beaconId],
      title: map[DatabaseConstants.title],
      artist: map[DatabaseConstants.artist],
      year: map[DatabaseConstants.year],
      paintingDescription: map[DatabaseConstants.paintingDescription],
      imagePath: map[DatabaseConstants.imagePath],
      audioPath: map[DatabaseConstants.audioPath],
      createdAt: map[DatabaseConstants.createdAt],
      updatedAt: map[DatabaseConstants.updatedAt],
    );
  }

  PaintingModel copyWith({
    int? id,
    int? galleryId,
    int? beaconId,
    String? title,
    String? artist,
    String? year,
    String? paintingDescription,
    String? imagePath,
    String? audioPath,
    String? createdAt,
    String? updatedAt,
  }) {
    return PaintingModel(
      id: id ?? this.id,
      galleryId: galleryId ?? this.galleryId,
      beaconId: beaconId ?? this.beaconId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      year: year ?? this.year,
      paintingDescription: paintingDescription ?? this.paintingDescription,
      imagePath: imagePath ?? this.imagePath,
      audioPath: audioPath ?? this.audioPath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'PaintingModel('
        'id: $id, '
        'title: $title, '
        'artist: $artist, '
        'galleryId: $galleryId, '
        'beaconId: $beaconId'
        ')';
  }
}
