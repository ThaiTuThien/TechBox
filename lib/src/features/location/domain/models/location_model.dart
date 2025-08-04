import 'package:equatable/equatable.dart';

class LocationResponse extends Equatable {
  final String message;
  final dynamic data;

  const LocationResponse({required this.message, this.data});

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(message: json['message'], data: json['data']);
  }

  @override
  List<Object?> get props => [message, data];
}
