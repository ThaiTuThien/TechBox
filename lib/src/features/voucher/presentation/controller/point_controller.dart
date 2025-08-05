import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/voucher/application/point_service.dart';
import 'package:techbox/src/features/voucher/data/data-source/point_data_source.dart';
import 'package:techbox/src/features/voucher/data/repository/point_repository.dart';
import 'package:techbox/src/features/voucher/presentation/state/point_state.dart';

class PointController extends StateNotifier<PointState> {
  final PointService _service;

  PointController(this._service) : super(PointInitial());

  Future<void> fetchPoints() async {
    state = PointLoading();
    try {
      final result = await _service.getPoints();

      result.fold(
        (failure) {
          state = PointError(failure);
        },
        (success) {
          state = PointSuccess(success);
        },
      );
    } catch (e) {
      state = PointError(e.toString());
    }
  }

  Future<void> refreshPoints() async {
    final result = await _service.getPoints();
    result.fold(
      (failure) => state = PointError(failure),
      (success) => state = PointSuccess(success),
    );
  }
}

final pointControllerProvider =
    StateNotifierProvider<PointController, PointState>((ref) {
      final dataSource = PointDataSource();
      final repository = PointRepository(dataSource);
      final service = PointService(repository);
      return PointController(service);
    });
