import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String street;
  final String ward;
  final String district;
  final String city;
  final String country;

  const Address({
    this.street = "",
    this.ward = "",
    this.district = "",
    this.city = "",
    this.country = "",
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? "",
      ward: json['ward'] ?? "",
      district: json['district'] ?? "",
      city: json['city'] ?? "",
      country: json['country'] ?? "",
    );
  }

  @override
  List<Object?> get props => [street, ward, district, city, country];
}

class ProfileModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final Address address;
  final String role;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] as String? ?? '', 
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      address: Address.fromJson(json['address'] as Map<String, dynamic>? ?? {}),
      role: json['role'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, email, phoneNumber, address, role];
}
