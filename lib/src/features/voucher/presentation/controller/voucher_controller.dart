import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/voucher/application/voucher_service.dart';
import 'package:techbox/src/features/voucher/data/data-source/voucher_data_source.dart';
import 'package:techbox/src/features/voucher/data/repository/voucher_repository.dart';
import 'package:techbox/src/features/voucher/presentation/state/voucher_list_state.dart';

class VoucherListController extends StateNotifier<VoucherListState> {
  final VoucherService _service;
  VoucherListController(this._service) : super(VoucherListInitial());

  Future<void> fetchVouchers() async {
    state = VoucherListLoading();
    final result = await _service.getVouchers();
    result.fold(
      (failure) => state = VoucherListError(failure),
      (success) => state = VoucherListSuccess(success),
    );
  }

  Future<void> refreshData() async {
    final result = await _service.getVouchers();
    result.fold(
      (failure) => state = VoucherListError(failure),
      (success) => state = VoucherListSuccess(success),
    );
  }

  Future<void> exchangePoints(int points) async {
    final result = await _service.exchangePointsForVoucher(points);
    await result.fold(
      (failure) => throw Exception(failure),
      (success) async => await refreshData(),
    );
  }
}

final voucherListControllerProvider =
    StateNotifierProvider<VoucherListController, VoucherListState>((ref) {
      final dataSource = VoucherDataSource();
      final repository = VoucherRepository(dataSource);
      final service = VoucherService(repository);
      return VoucherListController(service);
    });
