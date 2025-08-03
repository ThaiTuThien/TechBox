import 'package:equatable/equatable.dart';

class VerifyEmailResponse extends Equatable {
  final String message;
  final dynamic data;

  const VerifyEmailResponse({required this.message, this.data});

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponse(message: json['message'], data: json['data']);
  }

  @override
  List<Object?> get props => [message, data];
}
