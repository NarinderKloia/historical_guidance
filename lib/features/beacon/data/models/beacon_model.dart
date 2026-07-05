import 'dart:convert';

import '../../../../core/database/database_constants.dart';

/// Represents a BLE Beacon attached to a painting.
///
/// Every beacon has a UUID, Major and Minor value.
/// These values are used to identify a nearby painting.
class BeaconModel {
  final int? id;
  final String uuid;
  final int major;
  final int minor;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BeaconModel({
    this.id,
    required this.uuid,
    required this.major,
    required this.minor,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert object into SQLite Map.
  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.uuid: uuid,
      DatabaseConstants.major: major,
      DatabaseConstants.minor: minor,
      DatabaseConstants.createdAt: createdAt.toIso8601String(),
      DatabaseConstants.updatedAt: updatedAt.toIso8601String(),
    };
  }

  /// Create object from SQLite Map.
  factory BeaconModel.fromMap(Map<String, dynamic> map) {
    return BeaconModel(
      id: map[DatabaseConstants.id],
      uuid: map[DatabaseConstants.uuid],
      major: map[DatabaseConstants.major],
      minor: map[DatabaseConstants.minor],
      createdAt: DateTime.parse(map[DatabaseConstants.createdAt]),
      updatedAt: DateTime.parse(map[DatabaseConstants.updatedAt]),
    );
  }

  /// Convert object to JSON.
  String toJson() => jsonEncode(toMap());

  /// Create object from JSON.
  factory BeaconModel.fromJson(String source) =>
      BeaconModel.fromMap(jsonDecode(source));

  /// Returns a new object with modified values.
  BeaconModel copyWith({
    int? id,
    String? uuid,
    int? major,
    int? minor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BeaconModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      major: major ?? this.major,
      minor: minor ?? this.minor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'BeaconModel(id: $id, uuid: $uuid, major: $major, minor: $minor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BeaconModel &&
            other.id == id &&
            other.uuid == uuid &&
            other.major == major &&
            other.minor == minor &&
            other.createdAt == createdAt &&
            other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(id, uuid, major, minor, createdAt, updatedAt);
  }
}
