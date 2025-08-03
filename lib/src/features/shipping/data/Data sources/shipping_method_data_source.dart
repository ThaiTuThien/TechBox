import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'dart:convert';

import 'package:techbox/src/features/shipping/domain/Models/shipping_method.dart';

class ShippingMethodDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<List<ShippingMethod>> calculateFee (CalculateFeeDto dto) async {
    final url = Uri.parse('$baseUrl/api/v1/shipping-methods/calculate-fee');
    final response = await http.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(dto.toJson())
    );

    if (response.statusCode == 200){
      final data = jsonDecode(response.body) ['data'] ['methods'] as List;
      return data.map((json) => ShippingMethod.fromJson(json)).toList();
    }
    else{
      throw Exception('Api error : ${response.statusCode}');
    }
  }
}