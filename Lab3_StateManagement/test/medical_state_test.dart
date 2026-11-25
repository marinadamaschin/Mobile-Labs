import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab3_state_management/data/models/app_data.dart';
import 'package:lab3_state_management/state/medical_state.dart';

void main() {
  final raw = {
    'homeScreen': {
      'user': {
        'name': 'Ana',
        'greeting': 'Hi Ana',
        'subtitle': 'Hello',
        'avatarUrl': ''
      },
      'notifications': {'hasUnread': false},
      'search': {'hint': 'Search'},
      'appointment': {
        'title': 'Appointment',
        'date': 'Today',
        'time': '10 AM',
        'doctor': {'name': 'Dr X', 'specialty': 'General', 'avatarUrl': ''}
      },
      'healthServices': <Map<String, dynamic>>[],
      'nearbyDoctors': [
        {
          'id': 'a',
          'name': 'Dr. Zoe',
          'specialty': 'Dental Specialist',
          'category': 'tooth',
          'distance': '300M',
          'distanceMeters': 300,
          'avatarUrl': '',
          'isFavorite': false
        },
        {
          'id': 'b',
          'name': 'Dr. Amy',
          'specialty': 'Eye Specialist',
          'category': 'eye',
          'distance': '100M',
          'distanceMeters': 100,
          'avatarUrl': '',
          'isFavorite': false
        },
      ],
    },
    'appointmentDetails': {
      'title': 'Appointment',
      'doctor': {'name': 'Dr X', 'clinic': 'Clinic'},
      'payment': {'amount': 100, 'currency': 'USD'},
      'details': {'description': ''},
      'workingHours': {'slots': []},
      'date': {'slots': []}
    },
  };
  final data =
      AppData.fromJson(jsonDecode(jsonEncode(raw)) as Map<String, dynamic>);

  test('searches case-insensitively', () {
    final state =
        MedicalState(status: LoadStatus.success, data: data, query: 'DENTAL');
    expect(state.filteredDoctors.map((d) => d.id).toList(), ['a']);
  });

  test('filters by medical category', () {
    final state =
        MedicalState(status: LoadStatus.success, data: data, category: 'eye');
    expect(state.filteredDoctors.single.name, 'Dr. Amy');
  });

  test('sorts by distance', () {
    final state = MedicalState(
        status: LoadStatus.success, data: data, sort: DoctorSort.nearestFirst);
    expect(state.filteredDoctors.map((d) => d.id).toList(), ['b', 'a']);
  });

  test('favorites-only filter returns selected doctor', () {
    final state = MedicalState(
        status: LoadStatus.success,
        data: data,
        onlyFavorites: true,
        favoriteIds: {'a'});
    expect(state.filteredDoctors.map((d) => d.id).toList(), ['a']);
  });

  test('empty search returns zero matches', () {
    final state = MedicalState(
        status: LoadStatus.empty, data: data, query: 'no-such-doctor');
    expect(state.filteredDoctors, isEmpty);
  });
}
