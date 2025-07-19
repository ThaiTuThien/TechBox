import 'package:equatable/equatable.dart';

class LoginDto extends Equatable {
  final String email;
  final String password;
  final String role;

  const LoginDto ({
    required this.email,
    required this.password,
    required this.role
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'role': role
  };
  
  @override
  List<Object?> get props => [email, password, role];
}