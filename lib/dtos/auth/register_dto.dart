import 'package:equatable/equatable.dart';

class RegisterDto extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterDto({
    required this.name, 
    required this.email,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password
  };

  @override
  List<Object?> get props => [name, email, password];
}