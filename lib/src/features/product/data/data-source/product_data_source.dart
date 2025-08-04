import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:techbox/src/features/product/domain/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSource {
  Future<ProductResponse> getAllProduct() async {
    final baseURL = dotenv.env['URL_SERVER'];
    final url = Uri.parse('$baseURL/api/v1/products');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ProductResponse.fromJson(decoded);
    }
    else {
      final decoded = jsonDecode(response.body);
      final message = decoded['message'];
      throw Exception(message);
    }
  }
}
