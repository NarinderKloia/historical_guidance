class BeaconModel {
  final String uuid;
  final int major;
  final int minor;

  const BeaconModel({
    required this.uuid,
    required this.major,
    required this.minor,
  });

  BeaconModel copyWith({String? uuid, int? major, int? minor}) {
    return BeaconModel(
      uuid: uuid ?? this.uuid,
      major: major ?? this.major,
      minor: minor ?? this.minor,
    );
  }

  Map<String, dynamic> toMap() {
    return {'uuid': uuid, 'major': major, 'minor': minor};
  }

  factory BeaconModel.fromMap(Map<String, dynamic> map) {
    return BeaconModel(
      uuid: map['uuid'],
      major: map['major'],
      minor: map['minor'],
    );
  }
}
