import 'package:equatable/equatable.dart';

class UpdateProfileDto  extends Equatable{
  final String name;
  final String email;
  final String address;

  const UpdateProfileDto({
    required this.name, 
    required this.email,
    required this.address
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'address': address
  };

  @override
  List<Object?> get props => [name, email, address];
}