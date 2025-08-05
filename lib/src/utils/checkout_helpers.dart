import 'package:flutter/material.dart';
import 'package:techbox/src/features/auth/profile/domain/models/profile_model.dart';

class CheckoutHelpers {
  static String formatAddress(Address address) {
    final parts = <String>[];

    if (address.street.isNotEmpty) parts.add(address.street);
    if (address.ward.isNotEmpty) parts.add(address.ward);
    if (address.district.isNotEmpty) parts.add(address.district);
    if (address.city.isNotEmpty) parts.add(address.city);
    if (address.country.isNotEmpty) parts.add(address.country);

    if (parts.isEmpty) {
      return 'Chưa có địa chỉ giao hàng';
    }

    final formattedParts = <String>[];

    if (address.street.isNotEmpty) {
      formattedParts.add(address.street);
    }

    if (address.ward.isNotEmpty) {
      formattedParts.add('${address.ward}');
    }

    if (address.district.isNotEmpty) {
      formattedParts.add('${address.district}');
    }

    if (address.city.isNotEmpty) {
      formattedParts.add(address.city);
    }

    if (address.country.isNotEmpty && address.country != 'Vietnam') {
      formattedParts.add(address.country);
    }

    return formattedParts.join(', ');
  }

  static Color parseColor(String colorCode) {
    try {
      String hex = colorCode.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      int colorInt = int.parse(hex, radix: 16);
      return Color(colorInt);
    } catch (e) {
      return Colors.grey;
    }
  }

  static bool isHoChiMinhCity(Address address) {
    final city = address.city.toLowerCase();
    return city.contains('hồ chí minh') ||
        city.contains('ho chi minh') ||
        city.contains('tp.hcm');
  }

  static String getShippingDescription(String type) {
    switch (type) {
      case 'standard':
        return 'Ngày nhận dự kiến: 3-5 ngày làm việc';
      case 'express':
        return 'Ngày nhận dự kiến: 1-2 ngày làm việc';
      case 'super-express':
        return 'Giao hàng 4 giờ tới (chỉ TP.HCM)';
      default:
        return 'Thời gian giao hàng theo đơn vị vận chuyển';
    }
  }

  static Color getShippingColor(String type) {
    switch (type) {
      case 'standard':
        return const Color.fromARGB(90, 9, 162, 134);
      case 'express':
        return const Color.fromARGB(90, 220, 123, 7);
      case 'super-express':
        return const Color.fromARGB(90, 229, 51, 51);
      default:
        return const Color.fromARGB(90, 128, 128, 128);
    }
  }

  static Color getShippingBorderColor(String type) {
    switch (type) {
      case 'standard':
        return const Color.fromARGB(255, 9, 162, 133);
      case 'express':
        return const Color.fromARGB(255, 220, 123, 7);
      case 'super-express':
        return const Color.fromARGB(255, 229, 51, 51);
      default:
        return const Color.fromARGB(255, 128, 128, 128);
    }
  }

  static IconData getShippingIcon(String type) {
    switch (type) {
      case 'standard':
        return Icons.local_shipping;
      case 'express':
        return Icons.flash_on;
      case 'super-express':
        return Icons.rocket_launch;
      default:
        return Icons.local_shipping;
    }
  }

  static String getPaymentMethod(int selectedPaymentMethod) {
    switch (selectedPaymentMethod) {
      case 0:
        return 'stripe';
      case 1:
        return 'momo';
      case 2:
        return 'cod';
      default:
        return 'stripe';
    }
  }
} 