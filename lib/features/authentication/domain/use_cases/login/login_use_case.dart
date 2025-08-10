import 'package:ecommerce_app/features/authentication/domain/entities/login/login_entity.dart';

import '../../../../../core/utils/network_utils/network_service.dart';
import '../../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<Result<LoginEntity>> login(String email, String password) {
    return authRepository.login(email: email, password: password);
  }
}
