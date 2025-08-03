import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techbox/src/features/auth/verify_email/application/services/verify_email_services.dart';
import 'package:techbox/src/features/auth/verify_email/data/data-sources/verify_email_data_source.dart';
import 'package:techbox/src/features/auth/verify_email/data/repository/verify_email_repository.dart';
import 'package:techbox/src/features/auth/verify_email/domain/dtos/verify_email_dto.dart';
import 'package:techbox/src/features/auth/verify_email/presentation/states/verify_email_state.dart';

class VerifyEmailController extends StateNotifier<VerifyEmailState>{
  final VerifyEmailServices _services;

  VerifyEmailController(this._services): super (VerifyEmailInitial());

  Future<void> verifyEmail(VerifyEmailDto dto) async {
    state = VerifyEmailLoading();
    final data = await _services.verifyEmail(dto);
    data.fold(
      (err) => state = VerifyEmailError(err),
      (res) => state = VerifyEmailSuccess(res)
    );
  }
}

final verifyEmailControllerProvider = StateNotifierProvider<VerifyEmailController, VerifyEmailState>((ref) {
  final datasource = VerifyEmailDataSource();
  final repo = VerifyEmailRepository(datasource);
  final services = VerifyEmailServices(repo);
  return VerifyEmailController(services);
});