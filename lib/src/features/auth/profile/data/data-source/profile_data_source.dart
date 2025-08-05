import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';

class ProfileDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<ProfileModel> getProfile() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    print(token);
    if (token == null) {
      throw Exception('Token is null');
    }

    final url = Uri.parse('$baseUrl/api/v1/auth/profile');
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
      return ProfileModel.fromJson(data['data']);
    } else {
      throw Exception(
        'Failed to load profile: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phoneNumber,
    required String street,
    required String ward,
    required String district,
    required String city,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/api/v1/auth/update-profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'phoneNumber': phoneNumber,
        'address': {
          'street': street,
          'ward': ward,
          'district': district,
          'city': city,
        },
      }),
    );
    print(
      'Update Profile Status Code: ${response.statusCode}',
    ); // Thêm log để gỡ lỗi
    print(
      'Update Profile Response Body: ${response.body}',
    ); // Thêm log để gỡ lỗi

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to update profile: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
