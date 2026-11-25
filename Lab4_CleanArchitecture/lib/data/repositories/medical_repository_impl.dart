import '../../domain/entities/medical_entities.dart';
import '../../domain/repositories/medical_repository.dart';
import '../datasources/medical_remote_data_source.dart';
import '../models/medical_models.dart';

class MedicalRepositoryImpl implements MedicalRepository {
  final MedicalRemoteDataSource remote;
  const MedicalRepositoryImpl(this.remote);

  @override
  Future<AppData> getHomeData() async {
    final json = await remote.getFeed();
    return HomeResponseModel.fromJson(json).toEntity();
  }

  @override
  Future<AppointmentDetailsData> getAppointmentDetails() async {
    final json = await remote.getDetails();
    return DetailsResponseModel.fromJson(json).toEntity();
  }
}
