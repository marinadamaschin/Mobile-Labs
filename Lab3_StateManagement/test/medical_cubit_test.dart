import 'package:flutter_test/flutter_test.dart';
import 'package:lab3_state_management/data/models/app_data.dart';
import 'package:lab3_state_management/data/repositories/app_repository.dart';
import 'package:lab3_state_management/state/medical_cubit.dart';
import 'package:lab3_state_management/state/medical_state.dart';

class FakeRepository extends AppRepository {
  final AppData? result;
  final bool shouldFail;
  const FakeRepository(this.result, {this.shouldFail = false});

  @override
  Future<AppData> load() async {
    await Future<void>.delayed(Duration.zero);
    if (shouldFail) throw const FormatException('Broken JSON');
    return result!;
  }
}

AppData testData({bool empty = false}) => AppData.fromJson({
  'homeScreen': {
    'user': {'name': 'Ana', 'greeting': 'Hi, Ana', 'subtitle': 'Healthy!', 'avatarUrl': ''},
    'notifications': {'hasUnread': false},
    'search': {'hint': 'Search'},
    'appointment': {
      'title': 'Appointment', 'date': 'Today', 'time': '10:00 AM',
      'doctor': {'name': 'Dr. Upul', 'specialty': 'Dental Specialist', 'avatarUrl': ''},
    },
    'healthServices': <Map<String, dynamic>>[],
    'nearbyDoctors': empty ? <Map<String, dynamic>>[] : [
      {'id': '1', 'name': 'Dr. Amy', 'specialty': 'Dental Specialist',
        'distance': '300M', 'distanceMeters': 300, 'category': 'tooth',
        'avatarUrl': '', 'isFavorite': false},
    ],
  },
  'appointmentDetails': {
    'title': 'Appointment',
    'doctor': {'name': 'Dr. Upul', 'clinic': 'Denteeth'},
    'payment': {'amount': 120, 'currency': 'USD'},
    'details': {'description': ''},
    'workingHours': {'slots': [
      {'id': '11am', 'label': '11.00 AM', 'selected': true},
    ]},
    'date': {'slots': [
      {'id': 'sun-4', 'label': 'Sun 4', 'selected': true},
    ]},
  },
});

void main() {
  test('Cubit emits Loading, then Success when JSON parses', () async {
    final cubit = MedicalCubit(FakeRepository(testData()));

    final expectation = expectLater(
      cubit.stream.map((state) => state.status),
      emitsInOrder([
        LoadStatus.loading,
        LoadStatus.success,
      ]),
    );

    await cubit.load();
    await expectation;

    expect(cubit.state.status, LoadStatus.success);
    expect(cubit.state.data?.doctors.length, 1);

    await cubit.close();
  });

  test('Cubit emits Empty when JSON list is empty', () async {
    final cubit = MedicalCubit(FakeRepository(testData(empty: true)));
    await cubit.load();
    expect(cubit.state.status, LoadStatus.empty);
    await cubit.close();
  });

  test('Cubit emits Error when repository fails', () async {
    final cubit = MedicalCubit(const FakeRepository(null, shouldFail: true));
    await cubit.load();
    expect(cubit.state.status, LoadStatus.error);
    expect(cubit.state.errorMessage, contains('Broken JSON'));
    await cubit.close();
  });

  test('favorite toggle and empty search update state', () async {
    final cubit = MedicalCubit(FakeRepository(testData()));
    await cubit.load();
    cubit.toggleFavorite('1');
    expect(cubit.state.favoriteIds, contains('1'));
    cubit.toggleFavorite('1');
    expect(cubit.state.favoriteIds, isEmpty);
    cubit.search('not-found');
    expect(cubit.state.status, LoadStatus.empty);
    cubit.clearFilters();
    expect(cubit.state.status, LoadStatus.success);
    await cubit.close();
  });
}
