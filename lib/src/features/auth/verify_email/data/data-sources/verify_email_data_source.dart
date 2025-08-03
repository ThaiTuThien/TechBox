import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/auth/verify_email/domain/dtos/verify_email_dto.dart';
import 'package:http/http.dart' as http;

class VerifyEmailDataSource {
  Future<String> verifyEmail(VerifyEmailDto dto) async {
    final baseURL = dotenv.env['URL_SERVER'];
    final url = Uri.parse('$baseURL/api/v1/auth/verify-signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      if (decoded['message'] == 'Success') {
        final data = decoded['data'];
        final accessToken = data['accessToken'];
        final name = data['name'];

        final pref = await SharedPreferences.getInstance();
        await pref.setString('accessToken', accessToken);
        await pref.setString('name', name);
      }
      return decoded['message'];
    } else {
      final decoded = jsonDecode(response.body);
      final message = decoded['message'] ?? 'Lỗi không xác định';
      throw Exception(message);
    }
  }
}
