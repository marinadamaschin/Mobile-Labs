import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab4_clean_architecture/data/datasources/medical_remote_data_source.dart';
import 'package:lab4_clean_architecture/data/repositories/medical_repository_impl.dart';
import 'sample_data.dart';

void main() {
  test('Makes a GET request to each REST endpoint', () async {
    final visited = <String>[];
    final client = MockClient((request) async {
      visited.add(request.url.path);
      expect(request.method, 'GET');
      expect(request.headers['Accept'], 'application/json');
      final body =
          request.url.path.endsWith('/details') ? detailsJson : feedJson;
      return http.Response(jsonEncode(body), 200);
    });
    final repository = MedicalRepositoryImpl(MedicalRemoteDataSource(client));
    expect((await repository.getHomeData()).doctors.length, 2);
    expect((await repository.getAppointmentDetails()).amount, 120);
    expect(visited, [
      '/lab2026/v2/feed',
      '/lab2026/v2/feed/details',
    ]);
    client.close();
  });

  test('Non-200 HTTP response produces an error', () async {
    final client = MockClient((_) async => http.Response('Unavailable', 503));
    final remote = MedicalRemoteDataSource(client);
    await expectLater(remote.getFeed(), throwsException);
    client.close();
  });
}
