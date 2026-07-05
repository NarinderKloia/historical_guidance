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

  Future<void> updateMuseum(MuseumModel museum) async {
    await _repository.updateMuseum(museum);
  }

  Future<void> deleteMuseum(int id) async {
    await _repository.deleteMuseum(id);
  }
}
