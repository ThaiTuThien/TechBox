import 'package:equatable/equatable.dart';

class ResendOTPDto extends Equatable{
  final String email;

  const ResendOTPDto({
    required this.email
  });

  Map<String, dynamic> toJson() => {
    'email': email
  };
  
  @override
  List<Object?> get props => [email];
}