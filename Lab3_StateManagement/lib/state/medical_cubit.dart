import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/app_repository.dart';
import 'medical_state.dart';

class MedicalCubit extends Cubit<MedicalState> {
  final AppRepository repository;

  MedicalCubit(this.repository) : super(const MedicalState());

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, errorMessage: ''));
    try {
      final data = await repository.load();
      final favorites = data.doctors
          .where((d) => d.initiallyFavorite)
          .map((d) => d.id)
          .toSet();
      final hours = data.details.hours;
      final dates = data.details.dates;
      final selectedHour = hours.isEmpty
          ? ''
          : hours.firstWhere((s) => s.selected, orElse: () => hours.first).id;
      final selectedDate = dates.isEmpty
          ? ''
          : dates.firstWhere((s) => s.selected, orElse: () => dates.first).id;
      emit(MedicalState(
        status: data.doctors.isEmpty ? LoadStatus.empty : LoadStatus.success,
        data: data,
        favoriteIds: favorites,
        selectedHourId: selectedHour,
        selectedDateId: selectedDate,
      ));
    } catch (error) {
      emit(state.copyWith(
          status: LoadStatus.error, errorMessage: error.toString()));
    }
  }

  void _emitFiltered(MedicalState next) {
    emit(next.copyWith(
      status:
          next.filteredDoctors.isEmpty ? LoadStatus.empty : LoadStatus.success,
    ));
  }

  void search(String value) {
    if (state.data == null) return;
    _emitFiltered(state.copyWith(query: value));
  }

  void setCategory(String? id) {
    if (state.data == null) return;
    _emitFiltered(state.copyWith(category: id, clearCategory: id == null));
  }

  void setSort(DoctorSort value) {
    if (state.data == null) return;
    _emitFiltered(state.copyWith(sort: value));
  }

  void toggleFavorite(String doctorId) {
    if (state.data == null) return;
    final ids = Set<String>.of(state.favoriteIds);
    if (!ids.add(doctorId)) ids.remove(doctorId);
    _emitFiltered(state.copyWith(favoriteIds: ids));
  }

  void toggleOnlyFavorites() {
    if (state.data == null) return;
    _emitFiltered(state.copyWith(onlyFavorites: !state.onlyFavorites));
  }

  void toggleShowAll() {
    if (state.data == null) return;
    emit(state.copyWith(showAll: !state.showAll));
  }

  void clearFilters() {
    if (state.data == null) return;
    _emitFiltered(state.copyWith(
      query: '',
      clearCategory: true,
      onlyFavorites: false,
    ));
  }

  void selectHour(String id) => emit(state.copyWith(selectedHourId: id));

  void selectDate(String id) => emit(state.copyWith(selectedDateId: id));
}
