import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_clean_architecture/data/models/medical_models.dart';
import 'sample_data.dart';

void main() {
  test('Deserialize feed JSON into domain entities', () {
    final model = HomeResponseModel.fromJson(feedJson);
    final home = model.toEntity();
    expect(home.user.name, 'Jonathan');
    expect(home.doctors.length, 2);
    expect(home.doctors.first.distanceMeters, 500);
    expect(home.doctors.last.serviceCategory, 'tooth');
    expect(model.toJson()['nearbyDoctors'], isA<List<dynamic>>());
  });

  test('Deserialize details JSON and selected slot', () {
    final model = DetailsResponseModel.fromJson(detailsJson);
    final details = model.toEntity();
    expect(details.doctorName, 'Dr.Upul');
    expect(details.amount, 120);
    expect(details.hours.singleWhere((item) => item.selected).id, '11am');
    expect(details.bookingEnabled, true);
    expect(model.toJson()['title'], 'Appointment');
  });

  test('Reject malformed feed instead of silently showing fake data', () {
    expect(
        () => HomeResponseModel.fromJson({}).toEntity(), throwsFormatException);
  });
}
