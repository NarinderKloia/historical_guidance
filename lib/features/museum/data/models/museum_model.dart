import '../../../../core/database/database_constants.dart';

class MuseumModel {
  final int? id;
  final String museumName;
  final String city;
  final String museumDescription;
  final String createdAt;
  final String updatedAt;

  const MuseumModel({
    this.id,
    required this.museumName,
    required this.city,
    required this.museumDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.museumName: museumName,
      DatabaseConstants.city: city,
      DatabaseConstants.museumDescription: museumDescription,
      DatabaseConstants.createdAt: createdAt,
      DatabaseConstants.updatedAt: updatedAt,
    };
  }

  factory MuseumModel.fromMap(Map<String, dynamic> map) {
    return MuseumModel(
      id: map[DatabaseConstants.id],
      museumName: map[DatabaseConstants.museumName],
      city: map[DatabaseConstants.city],
      museumDescription: map[DatabaseConstants.museumDescription],
      createdAt: map[DatabaseConstants.createdAt],
      updatedAt: map[DatabaseConstants.updatedAt],
    );
  }

  MuseumModel copyWith({
    int? id,
    String? museumName,
    String? city,
    String? museumDescription,
    String? createdAt,
    String? updatedAt,
  }) {
    return MuseumModel(
      id: id ?? this.id,
      museumName: museumName ?? this.museumName,
      city: city ?? this.city,
      museumDescription: museumDescription ?? this.museumDescription,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'MuseumModel(id: $id, museumName: $museumName, city: $city)';
  }
}
