import 'beacon.dart';

class PaintingModel {
  final int? id;
  final int museumId;

  final String title;
  final String artist;
  final String year;
  final String description;

  /// Local image path
  final String imagePath;

  final BeaconModel beacon;

  final DateTime createdAt;
  final DateTime updatedAt;

  const PaintingModel({
    this.id,
    required this.museumId,
    required this.title,
    required this.artist,
    required this.year,
    required this.description,
    required this.imagePath,
    required this.beacon,
    required this.createdAt,
    required this.updatedAt,
  });

  PaintingModel copyWith({
    int? id,
    int? museumId,
    String? title,
    String? artist,
    String? year,
    String? description,
    String? imagePath,
    BeaconModel? beacon,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaintingModel(
      id: id ?? this.id,
      museumId: museumId ?? this.museumId,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      year: year ?? this.year,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      beacon: beacon ?? this.beacon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'museumId': museumId,
      'title': title,
      'artist': artist,
      'year': year,
      'description': description,
      'imagePath': imagePath,

      // Flatten beacon fields for SQLite
      'uuid': beacon.uuid,
      'major': beacon.major,
      'minor': beacon.minor,

      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory PaintingModel.fromMap(Map<String, dynamic> map) {
    return PaintingModel(
      id: map['id'],
      museumId: map['museumId'],
      title: map['title'],
      artist: map['artist'],
      year: map['year'],
      description: map['description'],
      imagePath: map['imagePath'],
      beacon: BeaconModel(
        uuid: map['uuid'],
        major: map['major'],
        minor: map['minor'],
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
