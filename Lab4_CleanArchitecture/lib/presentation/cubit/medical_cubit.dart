import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_home_data.dart';
import '../../domain/usecases/get_appointment_details.dart';
import 'medical_state.dart';
import '../../domain/entities/medical_entities.dart';

class MedicalCubit extends Cubit<MedicalState> {
  final GetHomeData getHomeData;
  final GetAppointmentDetails getAppointmentDetails;

  MedicalCubit(this.getHomeData, this.getAppointmentDetails)
      : super(const MedicalState());

  Future<void> loadHome() async {
    emit(state.copyWith(status: LoadStatus.loading, errorMessage: ''));
    try {
      final data = await getHomeData();
      if (isClosed) return;
      final favoriteIds = data.doctors
          .where((doctor) => doctor.initiallyFavorite)
          .map((doctor) => doctor.id)
          .toSet();
      emit(state.copyWith(
        status: data.doctors.isEmpty ? LoadStatus.empty : LoadStatus.success,
        data: data,
        favoriteIds: favoriteIds,
      ));
    } catch (error) {
      if (!isClosed)
        emit(state.copyWith(
          status: LoadStatus.error,
          errorMessage: error.toString(),
        ));
    }
  }

  Future<void> loadDetails() async {
    emit(state.copyWith(detailsStatus: LoadStatus.loading, detailsError: ''));
    try {
      final details = await getAppointmentDetails();
      if (isClosed) return;
      String initialId(List<SelectionSlot> slots) {
        if (slots.isEmpty) return '';
        for (final slot in slots) {
          if (slot.selected == true) return slot.id;
        }
        return slots.first.id;
      }

      emit(state.copyWith(
        detailsStatus: LoadStatus.success,
        details: details,
        selectedHourId: initialId(details.hours),
        selectedDateId: initialId(details.dates),
      ));
    } catch (error) {
      if (!isClosed)
        emit(state.copyWith(
          detailsStatus: LoadStatus.error,
          detailsError: error.toString(),
        ));
    }
  }

  void _emitFiltered(MedicalState next) {
    emit(next.copyWith(
        status: next.filteredDoctors.isEmpty
            ? LoadStatus.empty
            : LoadStatus.success));
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
    _emitFiltered(
        state.copyWith(query: '', clearCategory: true, onlyFavorites: false));
  }

  void selectHour(String id) => emit(state.copyWith(selectedHourId: id));
  void selectDate(String id) => emit(state.copyWith(selectedDateId: id));
}
