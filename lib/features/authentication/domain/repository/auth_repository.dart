import 'package:ecommerce_app/features/authentication/domain/entities/login/login_entity.dart';

import '../../../../core/utils/network_utils/network_service.dart';
import '../entities/register/registred_user_entity.dart';

abstract class AuthRepository {
  Future<Result<RegistredUserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Result<LoginEntity>> login(
      {required String email, required String password});
}
