import 'package:equatable/equatable.dart';

class ProvinceDto extends Equatable {
  final int code;
  final String name;
  final List<DistrictDto> districts;

  const ProvinceDto({
    required this.code,
    required this.name,
    required this.districts,
  });

  factory ProvinceDto.fromJson(Map<String, dynamic> json) {
    final districtsList =
        (json['districts'] as List? ?? [])
            .map((e) => DistrictDto.fromJson(e as Map<String, dynamic>))
            .toList();
    return ProvinceDto(
      code: json['code'] as int,
      name: json['name'] as String,
      districts: districtsList,
    );
  }

  @override
  List<Object?> get props => [code, name, districts];
}

class DistrictDto extends Equatable {
  final int code;
  final String name;
  final List<WardDto> wards;

  const DistrictDto({
    required this.code,
    required this.name,
    required this.wards,
  });

  factory DistrictDto.fromJson(Map<String, dynamic> json) {
    final wardsList =
        (json['wards'] as List? ?? [])
            .map((e) => WardDto.fromJson(e as Map<String, dynamic>))
            .toList();
    return DistrictDto(
      code: json['code'] as int,
      name: json['name'] as String,
      wards: wardsList,
    );
  }

  @override
  List<Object?> get props => [code, name, wards];
}

class WardDto extends Equatable {
  final int code;
  final String name;

  const WardDto({required this.code, required this.name});

  factory WardDto.fromJson(Map<String, dynamic> json) {
    return WardDto(code: json['code'] as int, name: json['name'] as String);
  }

  @override
  List<Object?> get props => [code, name];
}
