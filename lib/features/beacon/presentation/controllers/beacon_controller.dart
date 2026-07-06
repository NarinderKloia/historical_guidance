import '../../data/models/beacon_model.dart';
import '../../data/repositories/beacon_repository.dart';

class BeaconController {
  BeaconController._();

  static final BeaconController instance = BeaconController._();

  final BeaconRepository _repository = BeaconRepository.instance;

  Future<int> addBeacon(BeaconModel beacon) {
    return _repository.insertBeacon(beacon);
  }

  Future<List<BeaconModel>> getBeacons() {
    return _repository.getAllBeacons();
  }

  Future<BeaconModel?> getBeacon(int id) {
    return _repository.getBeaconById(id);
  }

  Future<int> updateBeacon(BeaconModel beacon) {
    return _repository.updateBeacon(beacon);
  }

  Future<int> deleteBeacon(int id) {
    return _repository.deleteBeacon(id);
  }

  Future<List<BeaconModel>> getAvailableBeaconsForPainting(
    int? currentBeaconId,
  ) {
    return _repository.getAvailableBeaconsForPainting(currentBeaconId);
  }

  Future<List<BeaconModel>> getUnassignedBeacons() {
    return _repository.getUnassignedBeacons();
  }

  Future<bool> beaconExists({
    required String uuid,
    required int major,
    required int minor,
  }) {
    return _repository.beaconExists(uuid: uuid, major: major, minor: minor);
  }
}
