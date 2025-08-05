import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techbox/src/features/payment/domain/models/order_model.dart';

class PaymentDataSource {
  final String? baseUrl = dotenv.env['URL_SERVER'];

  Future<CreateOrderResponse> createOrder(CreateOrderRequest request) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    
    final url = Uri.parse('$baseUrl/api/v1/orders');
    final requestBody = jsonEncode(request.toJson());
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return CreateOrderResponse.fromJson(jsonData);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to create order');
    }
  }

  Future<CreateCheckoutResponse> createCheckout(CreateCheckoutRequest request) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    
    final url = Uri.parse('$baseUrl/api/v1/payment/create-checkout-session');
    final requestBody = jsonEncode(request.toJson());
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return CreateCheckoutResponse.fromJson(jsonData);
    } else {
      try {
        if (response.body.isNotEmpty) {
          final errorData = jsonDecode(response.body);
          throw Exception(errorData['message'] ?? 'Failed to create checkout');
        } else {
          throw Exception('Checkout API returned ${response.statusCode} with empty response body');
        }
      } catch (e) {
        if (e is FormatException) {
          throw Exception('Invalid JSON response from checkout API: ${response.body}');
        }
        rethrow;
      }
    }
  }

  Future<UpdateOrderPaymentResponse> updateOrderPayment(UpdateOrderPaymentRequest request) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('accessToken');
    
    final url = Uri.parse('$baseUrl/api/v1/orders/update-order-payment');
    final requestBody = jsonEncode(request.toJson());
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      return UpdateOrderPaymentResponse.fromJson(jsonData);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to update order payment');
    }
  }
} 