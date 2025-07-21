import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/auth/register/application/services/register_service.dart';
import 'package:techbox/src/features/auth/register/data/data-sources/register_data_source.dart';
import 'package:techbox/src/features/auth/register/data/dtos/register_dto.dart';
import 'package:techbox/src/features/auth/register/data/repositories/register_repository.dart';
import 'package:techbox/src/features/auth/register/presentation/states/register_state.dart';

class RegisterController extends StateNotifier<RegisterState>{
  final RegisterService _service;

  RegisterController(this._service) : super (RegisterInitial());

  Future<void> register(RegisterDto dto) async {
    state = RegisterLoading();
    final data = await _service.register(dto);
    data.fold(
      (err) => state = RegisterError(err),
      (res) => state = RegisterSuccess(res)
    );
  }
}

final registerControllerProvider = StateNotifierProvider<RegisterController, RegisterState>((ref) {
  final datasource = RegisterDataSource();
  final repository = RegisterRepository(datasource);
  final service = RegisterService(repository);
  return RegisterController(service);
});

