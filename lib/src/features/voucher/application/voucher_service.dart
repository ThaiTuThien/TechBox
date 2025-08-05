import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/voucher/data/repository/voucher_repository.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';

class VoucherService {
  final VoucherRepository _repository;
  VoucherService(this._repository);

  Future<Either<String, List<VoucherModel>>> getVouchers() async {
    return await _repository.getVouchers();
  }

  Future<Either<String, void>> exchangePointsForVoucher(int points) async {
    return await _repository.exchangePointsForVoucher(points);
  }
}
