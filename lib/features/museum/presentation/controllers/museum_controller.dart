import '../../data/models/museum_model.dart';
import '../../data/repositories/museum_repository.dart';

class MuseumController {
  MuseumController._();

  static final MuseumController instance = MuseumController._();

  final MuseumRepository _repository = MuseumRepository.instance;

  Future<List<MuseumModel>> getMuseums() {
    return _repository.getAllMuseums();
  }

  Future<int> addMuseum(MuseumModel museum) {
    return _repository.insertMuseum(museum);
  }

  Future<int> updateMuseum(MuseumModel museum) {
    return _repository.updateMuseum(museum);
  }

  Future<int> deleteMuseum(int id) {
    return _repository.deleteMuseum(id);
  }
}
