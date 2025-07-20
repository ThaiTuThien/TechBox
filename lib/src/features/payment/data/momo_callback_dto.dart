import 'package:equatable/equatable.dart';

class MomoCallbackDto extends Equatable{
  final String partnerCode;
  final String orderId;
  final String requestId;
  final int amount;
  final String orderInfo;
  final String orderType;
  final int transId;
  final int resultCode;
  final String message;
  final String payType;
  final int responseTime;
  final String? extraData;
  final String signature;

  const MomoCallbackDto({
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.orderInfo,
    required this.orderType,
    required this.transId,
    required this.resultCode,
    required this.message, 
    required this.payType,
    required this.responseTime,
    this.extraData,
    required this.signature
  });

  Map<String, dynamic> toJson() => {
    'partnerCode': partnerCode,
    'orderId': orderId,
    'requestId': requestId,
    'amount': amount,
    'orderInfo': orderInfo,
    'transId': transId,
    'resultCode': resultCode,
    'message': message,
    'payType': payType,
    'responseTime': responseTime,
    'extraData': extraData ?? "",
    'signature': signature
  };

  @override
  List<Object?> get props => [partnerCode, orderId, requestId, amount, orderInfo, orderType, transId, resultCode, message, payType, responseTime, extraData, signature];
}