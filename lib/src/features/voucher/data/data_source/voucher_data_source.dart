import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';

class VoucherDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<List<VoucherModel>> getVouchers() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');

    if (token == null) {
      throw Exception('Access Token not found');
    }

    final url = Uri.parse('$baseUrl/api/v1/points/vouchers');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final listData = jsonDecode(response.body)['data'] as List;
      return listData.map((json) => VoucherModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load vouchers: ${response.statusCode}');
    }
  }

  Future<void> exchangePointsForVoucher(int points) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    if (token == null) {
      throw Exception('Access Token not found');
    }

    final url = Uri.parse('$baseUrl/api/v1/points/exchange-voucher');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'pointsToUse': points}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['message'] ?? 'Không rõ lỗi';
      throw Exception('Đổi điểm thất bại: $errorMessage');
    }
  }
} 