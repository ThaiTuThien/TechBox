import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techbox/src/features/auth/register/data/dtos/register_dto.dart';
import 'package:http/http.dart' as http;

class RegisterDataSource {
  Future<String> register(RegisterDto dto) async {
    final baseURL = dotenv.env['URL_SERVER'];
    final url = Uri.parse('$baseURL/api/v1/auth/signup');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(dto.toJson()));

    if (response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final data = jsonRes['message'];
      return data;
    } else {
      final decoded = jsonDecode(response.body);
      final message = decoded['message'] ?? 'Lỗi không xác định';
      throw Exception(message);
    }
  }
}