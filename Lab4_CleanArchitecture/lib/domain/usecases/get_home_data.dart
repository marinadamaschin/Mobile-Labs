import '../entities/medical_entities.dart';
import '../repositories/medical_repository.dart';

class GetHomeData {
  final MedicalRepository repository;
  const GetHomeData(this.repository);

  Future<AppData> call() => repository.getHomeData();
}
