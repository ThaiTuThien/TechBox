import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String variantId;
  final String productName;
  final String imageUrl;
  final int price;
  final String colorName;
  final String colorCode;
  final String storage;
  int quantity;

  CartItem({
    required this.variantId,
    required this.productName,
    required this.imageUrl,
    required this.price,
    required this.colorName,
    required this.colorCode,
    required this.storage,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'variantId': variantId,
      'productName': productName,
      'imageUrl': imageUrl,
      'price': price,
      'colorName': colorName,
      'colorCode': colorCode,
      'storage': storage,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      variantId: json['variantId'] ?? '',
      productName: json['productName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: json['price'] ?? 0,
      colorName: json['colorName'] ?? '',
      colorCode: json['colorCode'] ?? '',
      storage: json['storage'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  @override
  List<Object> get props => [
    variantId,
    productName,
    imageUrl,
    price,
    colorName,
    colorCode,
    storage,
    quantity,
  ];
}
