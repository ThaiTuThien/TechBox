import 'package:flutter/material.dart';

class CartProduct {
  final String id;
  final String name;
  final String color;
  final Color colorValue;
  final int price;
  final int quantity;
  final String imageUrl;

  const CartProduct({
    required this.id,
    required this.name,
    required this.color,
    required this.colorValue,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  CartProduct copyWith({
    String? id,
    String? name,
    String? color,
    Color? colorValue,
    int? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      colorValue: colorValue ?? this.colorValue,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'colorValue': colorValue.toARGB32(),
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      colorValue: Color(json['colorValue'] as int),
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }
} 