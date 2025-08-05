import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/voucher/application/voucher_service.dart';
import 'package:techbox/src/features/voucher/data/data_source/voucher_data_source.dart';
import 'package:techbox/src/features/voucher/data/repository/voucher_repository.dart';
import 'package:techbox/src/features/voucher/presentation/state/voucher_state.dart';

class VoucherController extends StateNotifier<VoucherState> {
  final VoucherService _service;

  VoucherController(this._service) : super(VoucherInitial());

  Future<void> getVouchers() async {
    state = VoucherLoading();
    final result = await _service.getVouchers();
    result.fold(
      (failure) => state = VoucherError(failure),
      (vouchers) => state = VoucherSuccess(vouchers),
    );
  }

  Future<void> exchangePointsForVoucher(int points) async {
    final result = await _service.exchangePointsForVoucher(points);
    result.fold(
      (failure) => throw Exception(failure),
      (success) => null,
    );
  }
}

final voucherControllerProvider = StateNotifierProvider<VoucherController, VoucherState>((ref) {
  final dataSource = VoucherDataSource();
  final repository = VoucherRepository(dataSource);
  final service = VoucherService(repository);
  return VoucherController(service);
});
