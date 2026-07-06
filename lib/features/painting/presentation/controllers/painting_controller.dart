import '../../data/models/painting_model.dart';
import '../../data/repositories/painting_repository.dart';

class PaintingController {
  PaintingController._();

  static final PaintingController instance = PaintingController._();

  final PaintingRepository _repository = PaintingRepository.instance;

  Future<int> addPainting(PaintingModel painting) {
    return _repository.insertPainting(painting);
  }

  Future<List<PaintingModel>> getPaintings(int galleryId) {
    return _repository.getPaintingsByGallery(galleryId);
  }

  Future<PaintingModel?> getPainting(int id) {
    return _repository.getPaintingById(id);
  }

  Future<int> updatePainting(PaintingModel painting) {
    return _repository.updatePainting(painting);
  }

  Future<int> deletePainting(int id) {
    return _repository.deletePainting(id);
  }

  Future<bool> isBeaconAssigned(int beaconId) {
    return _repository.isBeaconAssigned(beaconId: beaconId);
  }
}
