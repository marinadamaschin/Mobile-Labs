import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_clean_architecture/domain/entities/medical_entities.dart';
import 'package:lab4_clean_architecture/domain/repositories/medical_repository.dart';
import 'package:lab4_clean_architecture/domain/usecases/get_appointment_details.dart';
import 'package:lab4_clean_architecture/domain/usecases/get_home_data.dart';
import 'package:lab4_clean_architecture/data/models/medical_models.dart';
import 'package:lab4_clean_architecture/presentation/cubit/medical_cubit.dart';
import 'package:lab4_clean_architecture/presentation/cubit/medical_state.dart';
import 'sample_data.dart';

class FakeRepository implements MedicalRepository {
  final bool failHome;
  final bool emptyHome;
  final bool failDetails;

  const FakeRepository(
      {this.failHome = false,
      this.emptyHome = false,
      this.failDetails = false});

  @override
  Future<AppData> getHomeData() async {
    await Future<void>.delayed(Duration.zero);
    if (failHome) throw Exception('HTTP 503');
    return HomeResponseModel.fromJson({
      ...feedJson,
      if (emptyHome) 'nearbyDoctors': <Map<String, dynamic>>[],
    }).toEntity();
  }

  @override
  Future<AppointmentDetailsData> getAppointmentDetails() async {
    await Future<void>.delayed(Duration.zero);
    if (failDetails) throw Exception('HTTP 500');
    return DetailsResponseModel.fromJson(detailsJson).toEntity();
  }
}

MedicalCubit makeCubit(MedicalRepository repo) =>
    MedicalCubit(GetHomeData(repo), GetAppointmentDetails(repo));

void main() {
  test('Loading then Success - listener registered before async call',
      () async {
    final cubit = makeCubit(const FakeRepository());
    final expectation = expectLater(
      cubit.stream.map((s) => s.status),
      emitsInOrder([LoadStatus.loading, LoadStatus.success]),
    );
    await cubit.loadHome();
    await expectation;
    expect(cubit.state.data!.doctors.length, 2);
    await cubit.close();
  });

  test('Empty home response', () async {
    final cubit = makeCubit(const FakeRepository(emptyHome: true));
    await cubit.loadHome();
    expect(cubit.state.status, LoadStatus.empty);
    await cubit.close();
  });

  test('Error on unavailable API', () async {
    final cubit = makeCubit(const FakeRepository(failHome: true));
    await cubit.loadHome();
    expect(cubit.state.status, LoadStatus.error);
    expect(cubit.state.errorMessage, contains('503'));
    await cubit.close();
  });

  test('Details use second API and selected slots come from server', () async {
    final cubit = makeCubit(const FakeRepository());
    await cubit.loadDetails();
    expect(cubit.state.detailsStatus, LoadStatus.success);
    expect(cubit.state.selectedHourId, '11am');
    expect(cubit.state.selectedDateId, 'sun-4');
    cubit.selectHour('10am');
    expect(cubit.state.selectedHourId, '10am');
    await cubit.close();
  });

  test('Details error is distinct from Home status', () async {
    final cubit = makeCubit(const FakeRepository(failDetails: true));
    await cubit.loadHome();
    await cubit.loadDetails();
    expect(cubit.state.status, LoadStatus.success);
    expect(cubit.state.detailsStatus, LoadStatus.error);
    await cubit.close();
  });

  test('Search, sort, service filter and favorites remain available', () async {
    final cubit = makeCubit(const FakeRepository());
    await cubit.loadHome();
    cubit.search('sonja');
    expect(cubit.state.filteredDoctors.single.id, 'doctor-002');
    cubit.clearFilters();
    cubit.setCategory('tooth');
    expect(cubit.state.filteredDoctors.single.name, contains('Sonja'));
    cubit.setCategory(null);
    cubit.setSort(DoctorSort.farthestFirst);
    expect(cubit.state.filteredDoctors.first.id, 'doctor-002');
    cubit.toggleOnlyFavorites();
    expect(cubit.state.filteredDoctors.length, 1);
    cubit.toggleFavorite('doctor-002');
    expect(cubit.state.status, LoadStatus.empty);
    await cubit.close();
  });
}
