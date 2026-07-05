import '../../data/models/gallery_model.dart';
import '../../data/repositories/gallery_repository.dart';

class GalleryController {
  GalleryController._();

  static final GalleryController instance = GalleryController._();

  final GalleryRepository _repository = GalleryRepository.instance;

  Future<int> addGallery(GalleryModel gallery) {
    return _repository.insertGallery(gallery);
  }

  Future<List<GalleryModel>> getGalleriesByMuseum(int museumId) {
    return _repository.getGalleriesByMuseum(museumId);
  }

  Future<GalleryModel?> getGalleryById(int id) {
    return _repository.getGalleryById(id);
  }

  Future<int> updateGallery(GalleryModel gallery) {
    return _repository.updateGallery(gallery);
  }

  Future<int> deleteGallery(int id) {
    return _repository.deleteGallery(id);
  }
}
