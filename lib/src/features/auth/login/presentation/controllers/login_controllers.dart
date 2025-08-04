import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/auth/login/application/services/login_service.dart';
import 'package:techbox/src/features/auth/login/data/data-source/login_data_source.dart';
import 'package:techbox/src/features/auth/login/data/dtos/login_dto.dart';
import 'package:techbox/src/features/auth/login/data/repository/login_repo.dart';
import 'package:techbox/src/features/auth/login/presentation/states/login_states.dart';

class LoginControllers extends StateNotifier<LoginState>{
  final LoginService _services;

  LoginControllers(this._services): super (LoginInitial());

  Future<void> login(LoginDto dto) async {
    state = LoginLoading();
    final data = await _services.login(dto);
    data.fold(
      (err) => state = LoginError(err), 
      (res) => state = LoginSuccess(res)
    );
  }
}

final loginControllerProvider = StateNotifierProvider<LoginControllers, LoginState>((ref) {
  final datasource = LoginDataSource();
  final repo = LoginRepo(datasource);
  final services = LoginService(repo);
  return LoginControllers(services);
});