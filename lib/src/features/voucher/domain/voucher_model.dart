import 'package:intl/intl.dart';

class VoucherModel {
  final String id;
  final String customer;
  final String code;
  final int discountAmount;
  final int pointsUsed;
  final String status;
  final DateTime validFrom;
  final DateTime validTo;

  VoucherModel({
    required this.id,
    required this.customer,
    required this.code,
    required this.discountAmount,
    required this.pointsUsed,
    required this.status,
    required this.validFrom,
    required this.validTo,
  });

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      id: json['_id'] as String,
      customer: json['customer'] as String,
      code: json['code'] as String,
      discountAmount: (json['discountAmount'] as num).toInt(),
      pointsUsed: (json['pointsUsed'] as num).toInt(),
      status: json['status'] as String,
      validFrom: DateTime.parse(json['validFrom'] as String),
      validTo: DateTime.parse(json['validTo'] as String),
    );
  }

  String get formattedDiscountAmount {
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'vi_VN',
      decimalDigits: 0,
    );
    return formatCurrency.format(discountAmount);
  }

  String get formattedValidTo {
    return DateFormat('dd/MM/yyyy').format(validTo);
  }
}
