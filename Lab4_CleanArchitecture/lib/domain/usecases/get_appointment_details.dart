import '../entities/medical_entities.dart';
import '../repositories/medical_repository.dart';

class GetAppointmentDetails {
  final MedicalRepository repository;
  const GetAppointmentDetails(this.repository);

  Future<AppointmentDetailsData> call() => repository.getAppointmentDetails();
}
