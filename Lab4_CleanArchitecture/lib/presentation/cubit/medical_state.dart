import 'package:equatable/equatable.dart';
import '../../domain/entities/medical_entities.dart';

enum LoadStatus { initial, loading, success, empty, error }

enum DoctorSort { original, nameAZ, nearestFirst, farthestFirst }

class MedicalState extends Equatable {
  final LoadStatus status;
  final LoadStatus detailsStatus;
  final AppData? data;
  final AppointmentDetailsData? details;
  final String query;
  final String? category;
  final DoctorSort sort;
  final Set<String> favoriteIds;
  final bool onlyFavorites;
  final bool showAll;
  final String selectedHourId;
  final String selectedDateId;
  final String errorMessage;
  final String detailsError;

  const MedicalState({
    this.status = LoadStatus.initial,
    this.detailsStatus = LoadStatus.initial,
    this.data,
    this.details,
    this.query = '',
    this.category,
    this.sort = DoctorSort.original,
    this.favoriteIds = const <String>{},
    this.onlyFavorites = false,
    this.showAll = false,
    this.selectedHourId = '',
    this.selectedDateId = '',
    this.errorMessage = '',
    this.detailsError = '',
  });

  bool isFavorite(Doctor doctor) => favoriteIds.contains(doctor.id);

  List<Doctor> get filteredDoctors {
    final doctors = List<Doctor>.of(data?.doctors ?? const <Doctor>[]);
    final term = query.trim().toLowerCase();
    doctors.removeWhere((doctor) {
      final matchesQuery = term.isEmpty ||
          doctor.name.toLowerCase().contains(term) ||
          doctor.specialty.toLowerCase().contains(term);
      final matchesCategory =
          category == null || doctor.serviceCategory == category;
      final matchesFavorites =
          !onlyFavorites || favoriteIds.contains(doctor.id);
      return !(matchesQuery && matchesCategory && matchesFavorites);
    });
    switch (sort) {
      case DoctorSort.original:
        break;
      case DoctorSort.nameAZ:
        doctors.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case DoctorSort.nearestFirst:
        doctors.sort((a, b) => (a.distanceMeters ?? 9999999)
            .compareTo(b.distanceMeters ?? 9999999));
        break;
      case DoctorSort.farthestFirst:
        doctors.sort((a, b) =>
            (b.distanceMeters ?? -1).compareTo(a.distanceMeters ?? -1));
        break;
    }
    return doctors;
  }

  bool get hasFilters =>
      query.trim().isNotEmpty || category != null || onlyFavorites;

  List<Doctor> get visibleDoctors => showAll || hasFilters
      ? filteredDoctors
      : filteredDoctors.take(2).toList();

  MedicalState copyWith({
    LoadStatus? status,
    LoadStatus? detailsStatus,
    AppData? data,
    AppointmentDetailsData? details,
    String? query,
    String? category,
    bool clearCategory = false,
    DoctorSort? sort,
    Set<String>? favoriteIds,
    bool? onlyFavorites,
    bool? showAll,
    String? selectedHourId,
    String? selectedDateId,
    String? errorMessage,
    String? detailsError,
  }) =>
      MedicalState(
        status: status ?? this.status,
        detailsStatus: detailsStatus ?? this.detailsStatus,
        data: data ?? this.data,
        details: details ?? this.details,
        query: query ?? this.query,
        category: clearCategory ? null : category ?? this.category,
        sort: sort ?? this.sort,
        favoriteIds: favoriteIds ?? this.favoriteIds,
        onlyFavorites: onlyFavorites ?? this.onlyFavorites,
        showAll: showAll ?? this.showAll,
        selectedHourId: selectedHourId ?? this.selectedHourId,
        selectedDateId: selectedDateId ?? this.selectedDateId,
        errorMessage: errorMessage ?? this.errorMessage,
        detailsError: detailsError ?? this.detailsError,
      );

  @override
  List<Object?> get props => [
        status,
        detailsStatus,
        data,
        details,
        query,
        category,
        sort,
        favoriteIds,
        onlyFavorites,
        showAll,
        selectedHourId,
        selectedDateId,
        errorMessage,
        detailsError,
      ];
}
