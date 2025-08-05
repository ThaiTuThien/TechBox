import 'package:techbox/src/features/voucher/domain/voucher_model.dart';

sealed class VoucherListState {}

class VoucherListInitial extends VoucherListState {}

class VoucherListLoading extends VoucherListState {}

class VoucherListError extends VoucherListState {
  final String message;
  VoucherListError(this.message);
}

class VoucherListSuccess extends VoucherListState {
  final List<VoucherModel> vouchers;
  VoucherListSuccess(this.vouchers);
}
