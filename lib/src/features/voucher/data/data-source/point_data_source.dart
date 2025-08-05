import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/voucher/domain/point_model.dart';

class PointDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<PointModel> getPoints() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');

    if (token == null) {
      throw Exception('Access Token is null or not found');
    }

    final url = Uri.parse('$baseUrl/api/v1/points');

    final response = await http
        .get(
          url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return PointModel.fromJson(data['data']);
    } else {
      throw Exception(
        'Failed to load customer points: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
