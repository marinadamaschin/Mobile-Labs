import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicalRemoteDataSource {
  static const baseUrl = 'https://test-api-jlbn.onrender.com';
  final http.Client client;

  const MedicalRemoteDataSource(this.client);

  Future<Map<String, dynamic>> getFeed() => _get('/lab2026/v2/feed');

  Future<Map<String, dynamic>> getDetails() => _get('/lab2026/v2/feed/details');

  Future<Map<String, dynamic>> _get(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await client.get(
      uri,
      headers: {'Accept': 'application/json'},
    ).timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode} when requesting $path');
    }
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected a JSON object from the API');
    }
    return decoded;
  }
}
