import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable{
  final String accessToken;
  final String name;
  final String message;

  const LoginResponse({
    required this.accessToken, required this.message, required this.name
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResponse(
      accessToken: data['accessToken'], 
      message: data['message'], 
      name: data['name']
    );
  }

  @override
  List<Object?> get props => [accessToken, name, message];
}