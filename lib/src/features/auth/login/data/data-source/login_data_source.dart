import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/auth/login/data/dtos/login_dto.dart';
import 'package:http/http.dart' as http;
import 'package:techbox/src/features/auth/login/domain/models/login_model.dart';


class LoginDataSource {
  Future<LoginResponse> login(LoginDto dto) async {
    final baseURL = dotenv.env['URL_SERVER'];
    final url = Uri.parse('$baseURL/api/v1/auth/login');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(dto.toJson()));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return LoginResponse.fromJson(decoded);
    }
    else {
      final decoded = jsonDecode(response.body);
      final message = decoded['message'];
      throw Exception(message);
    }
  }
}