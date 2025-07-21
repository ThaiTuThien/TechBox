import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final String message;
  final dynamic data;

  const RegisterResponse({required this.message, this.data});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(message: json['message'], data: json['data']);
  }

  @override
  List<Object?> get props => [message, data];
}
