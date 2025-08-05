import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:techbox/src/features/location/data/dtos/location_dtos.dart';

class LocationDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<List<Province>> fetchProvinces() async {
    final url = Uri.parse('$baseUrl/api/v1/provinces');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Province.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load Provinces : ${response.statusCode}-${response.body}',
      );
    }
  }

  Future<List<District>> fetchDistricts(int provinceCode) async {
    final url = Uri.parse('$baseUrl/api/v1/districts/$provinceCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => District.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load districts: ${response.statusCode}-${response.body}',
      );
    }
  }

  Future<List<Ward>> fetchWards(int districtCode) async {
    final url = Uri.parse('$baseUrl/api/v1/wards/$districtCode');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Ward.fromJson(json)).toList();
    } else {
      throw Exception(
        'Failed to load ward: ${response.statusCode}-${response.body}',
      );
    }
  }
}
