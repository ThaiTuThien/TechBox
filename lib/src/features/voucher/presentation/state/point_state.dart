import 'package:techbox/src/features/voucher/domain/point_model.dart';

sealed class PointState {}

class PointInitial extends PointState {}

class PointLoading extends PointState {}

class PointSuccess extends PointState {
  final PointModel response;

  PointSuccess(this.response);
}

class PointError extends PointState {
  final String message;

  PointError(this.message);
}
