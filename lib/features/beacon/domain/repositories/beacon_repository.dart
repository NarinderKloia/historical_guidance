import '../../data/models/beacon_model.dart';

abstract class BeaconRepository {
  Future<int> insertBeacon(BeaconModel beacon);

  Future<List<BeaconModel>> getAllBeacons();

  Future<BeaconModel?> getBeaconById(int id);

  Future<int> updateBeacon(BeaconModel beacon);

  Future<int> deleteBeacon(int id);
}
