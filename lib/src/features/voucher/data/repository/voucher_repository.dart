import 'package:dartz/dartz.dart';
import 'package:techbox/src/features/voucher/data/data_source/voucher_data_source.dart';
import 'package:techbox/src/features/voucher/domain/voucher_model.dart';

class VoucherRepository {
  final VoucherDataSource _dataSource;

  VoucherRepository(this._dataSource);

  Future<Either<String, List<VoucherModel>>> getVouchers() async {
    try {
      final vouchers = await _dataSource.getVouchers();
      return Right(vouchers);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, void>> exchangePointsForVoucher(int points) async {
    try {
      await _dataSource.exchangePointsForVoucher(points);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
