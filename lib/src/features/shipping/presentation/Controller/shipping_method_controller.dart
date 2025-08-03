import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/shipping/application/Service/shipping_method_service.dart';
import 'package:techbox/src/features/shipping/data/Data%20sources/shipping_method_data_source.dart';
import 'package:techbox/src/features/shipping/data/Dtos/calculate_fee_dto.dart';
import 'package:techbox/src/features/shipping/data/Repositories/shipping_method_repository.dart';
import 'package:techbox/src/features/shipping/presentation/State/shipping_method_state.dart';

class ShippingMethodController extends StateNotifier<ShippingMethodState>{
    final ShippingMethodService _service ;

    ShippingMethodController(this._service) : super(ShippingMethodInnitial());

    Future<void> calculateFee(CalculateFeeDto dto) async {
      state = ShippingMethodLoading();
      final result = await _service.calculateFee(dto);
      result.fold(
        (error) => state = ShippingMethodError(error.toString()),
        (methods) => state = ShippingMethodSuccess(methods),
      );
    }
}

final shippingMethodControllerProvider = StateNotifierProvider<ShippingMethodController, ShippingMethodState>((ref){
  final dataSource = ShippingMethodDataSource();
  final repository = ShippingMethodRepository(dataSource);
  final service = ShippingMethodService(repository);
  return ShippingMethodController(service);
});