import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';
import 'package:http/http.dart' as http;

class LocationDataSource {
  Future<List<ProvinceDto>> getProvinces() async {
    final baseURL = dotenv.env['URL_SERVER'];
    final url = Uri.parse('$baseURL/api/v1/provinces');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body) as List;
      return jsonRes
          .map((e) => ProvinceDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load provinces: ${response.body}');
    }
  }
}
