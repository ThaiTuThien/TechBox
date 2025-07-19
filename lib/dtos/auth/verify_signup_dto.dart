import 'package:equatable/equatable.dart';

class VerifySignupDto  extends Equatable{
  final String email;
  final String otp;

  const VerifySignupDto({
    required this.email,
    required this.otp
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'otp': otp
  };
  
  @override
  List<Object?> get props => [email, otp];
}