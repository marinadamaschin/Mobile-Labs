class UserProfile {
  final String name;
  final String greeting;
  final String subtitle;
  final String avatarUrl;

  const UserProfile(
      {required this.name,
      required this.greeting,
      required this.subtitle,
      required this.avatarUrl});

  factory UserProfile.fromJson(Map<String, dynamic> j) => UserProfile(
        name: j['name'] as String? ?? '',
        greeting: j['greeting'] as String? ?? '',
        subtitle: j['subtitle'] as String? ?? '',
        avatarUrl: j['avatarUrl'] as String? ?? '',
      );
}

class AppointmentSummary {
  final String title;
  final String date;
  final String time;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorAvatar;

  const AppointmentSummary(
      {required this.title,
      required this.date,
      required this.time,
      required this.doctorName,
      required this.doctorSpecialty,
      required this.doctorAvatar});

  factory AppointmentSummary.fromJson(Map<String, dynamic> j) {
    final d = j['doctor'] as Map<String, dynamic>? ?? {};
    return AppointmentSummary(
      title: j['title'] as String? ?? 'Appointment',
      date: j['date'] as String? ?? '',
      time: j['time'] as String? ?? '',
      doctorName: d['name'] as String? ?? '',
      doctorSpecialty: d['specialty'] as String? ?? '',
      doctorAvatar: d['avatarUrl'] as String? ?? '',
    );
  }
}

class HealthService {
  final String id;
  final String name;
  final String iconUrl;

  const HealthService(
      {required this.id, required this.name, required this.iconUrl});

  factory HealthService.fromJson(Map<String, dynamic> j) => HealthService(
        id: j['id'] as String? ?? '',
        name: j['name'] as String? ?? '',
        iconUrl: j['iconUrl'] as String? ?? '',
      );
}

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String distance;
  final int distanceMeters;
  final String category;
  final String avatarUrl;
  final String clinic;
  final double price;
  final bool initiallyFavorite;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.distance,
    required this.distanceMeters,
    required this.category,
    required this.avatarUrl,
    required this.clinic,
    required this.price,
    required this.initiallyFavorite,
  });

  factory Doctor.fromJson(Map<String, dynamic> j) => Doctor(
        id: j['id'] as String? ?? '',
        name: j['name'] as String? ?? '',
        specialty: j['specialty'] as String? ?? '',
        distance: j['distance'] as String? ?? '',
        distanceMeters: (j['distanceMeters'] as num?)?.toInt() ?? 0,
        category: j['category'] as String? ?? 'general',
        avatarUrl: j['avatarUrl'] as String? ?? '',
        clinic: j['clinic'] as String? ?? 'Medical Clinic',
        price: (j['price'] as num?)?.toDouble() ?? 120,
        initiallyFavorite: j['isFavorite'] as bool? ?? false,
      );
}

class SelectionSlot {
  final String id;
  final String label;
  final bool selected;

  const SelectionSlot(
      {required this.id, required this.label, required this.selected});

  factory SelectionSlot.fromJson(Map<String, dynamic> j) => SelectionSlot(
        id: j['id'] as String? ?? '',
        label: j['label'] as String? ?? '',
        selected: j['selected'] as bool? ?? false,
      );
}

class AppointmentDetailsData {
  final String title;
  final String fallbackDoctorName;
  final String fallbackClinic;
  final String fallbackAvatarUrl;
  final double amount;
  final String currency;
  final String description;
  final List<SelectionSlot> hours;
  final List<SelectionSlot> dates;
  final String buttonLabel;

  const AppointmentDetailsData({
    required this.title,
    required this.fallbackDoctorName,
    required this.fallbackClinic,
    required this.fallbackAvatarUrl,
    required this.amount,
    required this.currency,
    required this.description,
    required this.hours,
    required this.dates,
    required this.buttonLabel,
  });

  factory AppointmentDetailsData.fromJson(Map<String, dynamic> j) {
    final doctor = j['doctor'] as Map<String, dynamic>? ?? {};
    final payment = j['payment'] as Map<String, dynamic>? ?? {};
    final details = j['details'] as Map<String, dynamic>? ?? {};
    final hour = j['workingHours'] as Map<String, dynamic>? ?? {};
    final date = j['date'] as Map<String, dynamic>? ?? {};
    final actions = j['actions'] as Map<String, dynamic>? ?? {};
    final booking = actions['bookAppointment'] as Map<String, dynamic>? ?? {};
    List<SelectionSlot> parseSlots(dynamic raw) => raw is List
        ? raw
            .map((e) =>
                SelectionSlot.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList()
        : <SelectionSlot>[];
    return AppointmentDetailsData(
      title: j['title'] as String? ?? 'Appointment',
      fallbackDoctorName: doctor['name'] as String? ?? '',
      fallbackClinic: doctor['clinic'] as String? ?? '',
      fallbackAvatarUrl: doctor['avatarUrl'] as String? ?? '',
      amount: (payment['amount'] as num?)?.toDouble() ?? 0,
      currency: payment['currency'] as String? ?? 'USD',
      description: details['description'] as String? ?? '',
      hours: parseSlots(hour['slots']),
      dates: parseSlots(date['slots']),
      buttonLabel: booking['label'] as String? ?? 'Book an Appointment',
    );
  }
}

class AppData {
  final UserProfile user;
  final bool hasUnreadNotifications;
  final String searchHint;
  final AppointmentSummary appointment;
  final List<HealthService> services;
  final List<Doctor> doctors;
  final AppointmentDetailsData details;

  const AppData({
    required this.user,
    required this.hasUnreadNotifications,
    required this.searchHint,
    required this.appointment,
    required this.services,
    required this.doctors,
    required this.details,
  });

  factory AppData.fromJson(Map<String, dynamic> j) {
    final home = Map<String, dynamic>.from(j['homeScreen'] as Map);
    final notifications = home['notifications'] as Map<String, dynamic>? ?? {};
    final search = home['search'] as Map<String, dynamic>? ?? {};
    final rawDoctors = home['nearbyDoctors'] as List<dynamic>? ?? [];
    final rawServices = home['healthServices'] as List<dynamic>? ?? [];
    return AppData(
      user:
          UserProfile.fromJson(Map<String, dynamic>.from(home['user'] as Map)),
      hasUnreadNotifications: notifications['hasUnread'] as bool? ?? false,
      searchHint: search['hint'] as String? ?? 'Search something',
      appointment: AppointmentSummary.fromJson(
          Map<String, dynamic>.from(home['appointment'] as Map)),
      doctors: rawDoctors
          .map((e) => Doctor.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      services: rawServices
          .map((e) =>
              HealthService.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      details: AppointmentDetailsData.fromJson(
          Map<String, dynamic>.from(j['appointmentDetails'] as Map)),
    );
  }
}
