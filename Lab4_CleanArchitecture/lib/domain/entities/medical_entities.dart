// Domain entities contain the data needed by the app, not HTTP or JSON code.
class UserProfile {
  final String name;
  final String greeting;
  final String subtitle;
  final String avatarUrl;

  const UserProfile({
    required this.name,
    required this.greeting,
    required this.subtitle,
    required this.avatarUrl,
  });
}

class AppointmentSummary {
  final String title;
  final String date;
  final String time;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorAvatar;

  const AppointmentSummary({
    required this.title,
    required this.date,
    required this.time,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorAvatar,
  });
}

class HealthService {
  final String id;
  final String name;
  final String iconUrl;

  const HealthService({
    required this.id,
    required this.name,
    required this.iconUrl,
  });
}

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String distance;
  final String avatarUrl;
  final bool initiallyFavorite;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.distance,
    required this.avatarUrl,
    required this.initiallyFavorite,
  });

  // These values are derived locally, because the API does not send them.
  int? get distanceMeters {
    final match =
        RegExp(r'(\d+)\s*m\b', caseSensitive: false).firstMatch(distance);
    return match == null ? null : int.tryParse(match.group(1)!);
  }

  String? get serviceCategory {
    final text = specialty.toLowerCase();
    if (text.contains('dental') || text.contains('dentist')) return 'tooth';
    if (text.contains('eye') || text.contains('ophthalm')) return 'eye';
    if (text.contains('pulmo') || text.contains('lung')) return 'lungs';
    if (text.contains('ent') ||
        text.contains('hearing') ||
        text.contains('ear')) {
      return 'ear';
    }
    return null;
  }
}

class SelectionSlot {
  final String id;
  final String label;
  final bool selected;

  const SelectionSlot({
    required this.id,
    required this.label,
    required this.selected,
  });
}

class AppointmentDetailsData {
  final String title;
  final String doctorName;
  final String clinic;
  final String avatarUrl;
  final double amount;
  final String currency;
  final String description;
  final List<SelectionSlot> hours;
  final List<SelectionSlot> dates;
  final String buttonLabel;
  final bool bookingEnabled;

  const AppointmentDetailsData({
    required this.title,
    required this.doctorName,
    required this.clinic,
    required this.avatarUrl,
    required this.amount,
    required this.currency,
    required this.description,
    required this.hours,
    required this.dates,
    required this.buttonLabel,
    required this.bookingEnabled,
  });
}

class AppData {
  final UserProfile user;
  final bool hasUnreadNotifications;
  final String searchHint;
  final AppointmentSummary appointment;
  final List<HealthService> services;
  final List<Doctor> doctors;

  const AppData({
    required this.user,
    required this.hasUnreadNotifications,
    required this.searchHint,
    required this.appointment,
    required this.services,
    required this.doctors,
  });
}
