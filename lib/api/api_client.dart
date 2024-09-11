import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiClient {
  final String baseUrl = 'https://chinese-food-db.p.rapidapi.com/';
  final http.Client httpClient;

  final String apiKey = '';

  ApiClient({required this.httpClient});

  Future<http.Response?> getAllFoods() async {
    final response = await httpClient.get(
      Uri.parse(baseUrl),
      headers: {
        'x-rapidapi-host': 'chinese-food-db.p.rapidapi.com',
        'x-rapidapi-key': apiKey,
      },
    );
    if (response.statusCode != 200) {
      Logger().e('Request failed with status: ${response.statusCode}');
      return null;
    } else {
      return response;
    }
  }

  Future<Map<String, dynamic>?> getFoodDetailById(String id) async {
    final url = Uri.parse('$baseUrl$id'); // ID'ye göre URL oluşturuyoruz

    try {
      final response = await http.get(
        url,
        headers: {
          'x-rapidapi-host': 'chinese-food-db.p.rapidapi.com',
          'x-rapidapi-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        // Başarılı yanıt (200) olursa, JSON'u parse et
        return jsonDecode(response.body);
      } else {
        Logger().e(
            'Failed to load food detail, status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      Logger().e('Failed to fetch food info. $e');
      return null;
    }
  }
}
