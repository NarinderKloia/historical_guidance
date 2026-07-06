import '../../data/models/painting_model.dart';
import '../../data/repositories/painting_repository.dart';

class PaintingController {
  PaintingController._();

  static final PaintingController instance = PaintingController._();

  final PaintingRepository _repository = PaintingRepository.instance;

  // ==========================================================
  // Add Painting
  // ==========================================================

  Future<int> addPainting(PaintingModel painting) async {
    return await _repository.insertPainting(painting);
  }

  // ==========================================================
  // Get Painting By ID
  // ==========================================================

  Future<PaintingModel?> getPainting(int id) async {
    return await _repository.getPaintingById(id);
  }

  // ==========================================================
  // Get Paintings By Gallery
  // ==========================================================

  Future<List<PaintingModel>> getPaintings(int galleryId) async {
    return await _repository.getPaintingsByGallery(galleryId);
  }

  // ==========================================================
  // Get All Paintings
  // ==========================================================

  Future<List<PaintingModel>> getAllPaintings() async {
    return await _repository.getAllPaintings();
  }

  // ==========================================================
  // Update Painting
  // ==========================================================

  Future<int> updatePainting(PaintingModel painting) async {
    return await _repository.updatePainting(painting);
  }

  // ==========================================================
  // Delete Painting
  // ==========================================================

  Future<int> deletePainting(int id) async {
    return await _repository.deletePainting(id);
  }

  // ==========================================================
  // Check Beacon Assignment
  // ==========================================================

  Future<bool> isBeaconAssigned(int beaconId) async {
    return await _repository.isBeaconAssigned(beaconId: beaconId);
  }
}
