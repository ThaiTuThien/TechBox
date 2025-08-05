import 'package:equatable/equatable.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object?> get props => [];
}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherSuccess extends VoucherState {
  final List<VoucherModel> vouchers;

  const VoucherSuccess(this.vouchers);

  @override
  List<Object?> get props => [vouchers];
}

class VoucherError extends VoucherState {
  final String message;

  const VoucherError(this.message);

  @override
  List<Object?> get props => [message];
} 