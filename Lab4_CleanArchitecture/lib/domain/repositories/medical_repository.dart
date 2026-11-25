import '../entities/medical_entities.dart';

abstract class MedicalRepository {
  Future<AppData> getHomeData();
  Future<AppointmentDetailsData> getAppointmentDetails();
}
