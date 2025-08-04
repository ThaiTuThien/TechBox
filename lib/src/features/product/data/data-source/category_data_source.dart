import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:techbox/src/features/product/domain/category_model.dart';


class CategoryDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<List<CategoryModel>> getCategories() async {
    final url = Uri.parse('$baseUrl/api/v1/admin/categories');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodeBody = jsonDecode(response.body);
      final data = decodeBody['data'];

      final categories = data as List;
      return categories.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('API error: ${response.statusCode} - ${response.body}');
    }
  }
}
