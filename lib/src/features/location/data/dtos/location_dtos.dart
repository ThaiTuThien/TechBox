import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final int code;
  final String name;
  final List<dynamic> districts;

  const Province({
    required this.code,
    required this.name,
    required this.districts,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      code: json['code'] as int,
      name: json['name'] as String,
      districts: json['districts'] as List<dynamic>,
    );
  }

  @override
  List<Object?> get props => [code, name, districts];
}

class District extends Equatable {
  final int code;
  final String name;
  final List<dynamic> wards;

  const District({required this.code, required this.name, required this.wards});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      code: json['code'] as int,
      name: json['name'] as String,
      wards: json['wards'] as List<dynamic>,
    );
  }

  @override
  List<Object?> get props => [code, name, wards];
}

class Ward extends Equatable {
  final int code;
  final String name;

  const Ward({required this.code, required this.name});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(code: json['code'] as int, name: json['name'] as String);
  }

  @override
  List<Object?> get props => [code, name];
}
