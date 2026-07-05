class MuseumModel {
  final int? id;

  final String name;
  final String city;
  final String description;

  final DateTime createdAt;
  final DateTime updatedAt;

  const MuseumModel({
    this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  MuseumModel copyWith({
    int? id,
    String? name,
    String? city,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MuseumModel(
      id: id ?? this.id,
      name: name ?? this.name,
      city: city ?? this.city,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory MuseumModel.fromMap(Map<String, dynamic> map) {
    return MuseumModel(
      id: map['id'],
      name: map['name'],
      city: map['city'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
