import 'package:equatable/equatable.dart';

class VerifyEmailDto extends Equatable {
  final String email;
  final String otp;

  const VerifyEmailDto({required this.email, required this.otp});

  Map<String, String> toJson() => {'email': email, 'otp': otp};

  @override
  List<Object?> get props => [email, otp];
}
