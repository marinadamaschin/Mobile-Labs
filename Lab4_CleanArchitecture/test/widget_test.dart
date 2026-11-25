import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_clean_architecture/domain/repositories/medical_repository.dart';
import 'package:lab4_clean_architecture/domain/entities/medical_entities.dart';
import 'package:lab4_clean_architecture/domain/usecases/get_appointment_details.dart';
import 'package:lab4_clean_architecture/domain/usecases/get_home_data.dart';
import 'package:lab4_clean_architecture/main.dart';
import 'package:lab4_clean_architecture/presentation/cubit/medical_cubit.dart';

class NeverUsedRepo implements MedicalRepository {
  @override
  Future<AppData> getHomeData() => throw UnimplementedError();
  @override
  Future<AppointmentDetailsData> getAppointmentDetails() =>
      throw UnimplementedError();
}

void main() {
  testWidgets('Home initial state shows a loading spinner', (tester) async {
    final repository = NeverUsedRepo();
    await tester.pumpWidget(MedicalApp(
      createCubit: () => MedicalCubit(
          GetHomeData(repository), GetAppointmentDetails(repository)),
    ));
    expect(find.text('Loading doctors...'), findsOneWidget);
  });
}
