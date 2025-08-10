import 'package:ecommerce_app/features/authentication/domain/entities/register/registred_user_entity.dart';
import 'package:ecommerce_app/features/authentication/domain/repository/auth_repository.dart';

import '../../../../../core/utils/network_utils/network_service.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<Result<RegistredUserEntity>> register(
      String email, String password, String name) {
    return authRepository.register(
        email: email, password: password, name: name);
  }
}
