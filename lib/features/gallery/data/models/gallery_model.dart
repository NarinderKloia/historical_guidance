import '../../../../core/database/database_constants.dart';

class GalleryModel {
  final int? id;
  final int museumId;

  final String galleryName;
  final String floor;
  final String galleryDescription;

  final String createdAt;
  final String updatedAt;

  const GalleryModel({
    this.id,
    required this.museumId,
    required this.galleryName,
    required this.floor,
    required this.galleryDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.museumId: museumId,
      DatabaseConstants.galleryName: galleryName,
      DatabaseConstants.floor: floor,
      DatabaseConstants.galleryDescription: galleryDescription,
      DatabaseConstants.createdAt: createdAt,
      DatabaseConstants.updatedAt: updatedAt,
    };
  }

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(
      id: map[DatabaseConstants.id],
      museumId: map[DatabaseConstants.museumId],
      galleryName: map[DatabaseConstants.galleryName],
      floor: map[DatabaseConstants.floor],
      galleryDescription: map[DatabaseConstants.galleryDescription],
      createdAt: map[DatabaseConstants.createdAt],
      updatedAt: map[DatabaseConstants.updatedAt],
    );
  }

  GalleryModel copyWith({
    int? id,
    int? museumId,
    String? galleryName,
    String? floor,
    String? galleryDescription,
    String? createdAt,
    String? updatedAt,
  }) {
    return GalleryModel(
      id: id ?? this.id,
      museumId: museumId ?? this.museumId,
      galleryName: galleryName ?? this.galleryName,
      floor: floor ?? this.floor,
      galleryDescription: galleryDescription ?? this.galleryDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'GalleryModel('
        'id: $id, '
        'museumId: $museumId, '
        'galleryName: $galleryName, '
        'floor: $floor'
        ')';
  }
}
