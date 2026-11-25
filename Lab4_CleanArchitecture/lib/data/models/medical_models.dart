import '../../domain/entities/medical_entities.dart';

// Manual JSON serialization is intentionally used instead of code generation.
// Keeps this student project small and demonstrates fromJson / toJson clearly.
Map<String, dynamic> _object(Object? value) {
  if (value is! Map) throw const FormatException('Expected a JSON object');
  return Map<String, dynamic>.from(value);
}

List<Map<String, dynamic>> _objects(Object? value) {
  if (value is! List) throw const FormatException('Expected a JSON array');
  return value.map((item) => _object(item)).toList();
}

String _string(Object? value) => value is String ? value : '';

class HomeResponseModel {
  final Map<String, dynamic> json;
  const HomeResponseModel(this.json);

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(json);

  // The server payload is already a JSON-compatible map.
  Map<String, dynamic> toJson() => Map<String, dynamic>.from(json);

  AppData toEntity() {
    final user = _object(json['user']);
    final notifications = _object(json['notifications']);
    final search = _object(json['search']);
    final appointment = _object(json['appointment']);
    final appointmentDoctor = _object(appointment['doctor']);
    return AppData(
      user: UserProfile(
        name: _string(user['name']),
        greeting: _string(user['greeting']),
        subtitle: _string(user['subtitle']),
        avatarUrl: _string(user['avatarUrl']),
      ),
      hasUnreadNotifications: notifications['hasUnread'] == true,
      searchHint: _string(search['hint']),
      appointment: AppointmentSummary(
        title: _string(appointment['title']),
        date: _string(appointment['date']),
        time: _string(appointment['time']),
        doctorName: _string(appointmentDoctor['name']),
        doctorSpecialty: _string(appointmentDoctor['specialty']),
        doctorAvatar: _string(appointmentDoctor['avatarUrl']),
      ),
      services: _objects(json['healthServices'])
          .map((item) => HealthService(
                id: _string(item['id']),
                name: _string(item['name']),
                iconUrl: _string(item['iconUrl']),
              ))
          .toList(),
      doctors: _objects(json['nearbyDoctors'])
          .map((item) => Doctor(
                id: _string(item['id']),
                name: _string(item['name']),
                specialty: _string(item['specialty']),
                distance: _string(item['distance']),
                avatarUrl: _string(item['avatarUrl']),
                initiallyFavorite: item['isFavorite'] == true,
              ))
          .toList(),
    );
  }
}

class DetailsResponseModel {
  final Map<String, dynamic> json;
  const DetailsResponseModel(this.json);

  factory DetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      DetailsResponseModel(json);

  Map<String, dynamic> toJson() => Map<String, dynamic>.from(json);

  AppointmentDetailsData toEntity() {
    final doctor = _object(json['doctor']);
    final payment = _object(json['payment']);
    final details = _object(json['details']);
    final workingHours = _object(json['workingHours']);
    final date = _object(json['date']);
    final actions = _object(json['actions']);
    final bookAppointment = _object(actions['bookAppointment']);
    List<SelectionSlot> slots(Object? raw) => _objects(raw)
        .map(
          (s) => SelectionSlot(
            id: _string(s['id']),
            label: _string(s['label']),
            selected: s['selected'] == true,
          ),
        )
        .toList();
    return AppointmentDetailsData(
      title: _string(json['title']),
      doctorName: _string(doctor['name']),
      clinic: _string(doctor['clinic']),
      avatarUrl: _string(doctor['avatarUrl']),
      amount: (payment['amount'] as num?)?.toDouble() ?? 0,
      currency: _string(payment['currency']),
      description: _string(details['description']),
      hours: slots(workingHours['slots']),
      dates: slots(date['slots']),
      buttonLabel: _string(bookAppointment['label']),
      bookingEnabled: bookAppointment['enabled'] == true,
    );
  }
}
