import 'package:ecommerce_app/features/authentication/domain/entities/login/login_entity.dart';
import 'package:ecommerce_app/features/authentication/domain/entities/register/registred_user_entity.dart';
import 'package:ecommerce_app/features/authentication/domain/repository/auth_repository.dart';

import '../../../../core/utils/network_utils/network_service.dart';
import '../remote_data_source/auth_remote_data_source.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImplementation(this.remoteDataSource);

  @override
  Future<Result<LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.login(
      email: email,
      password: password,
    );

    return switch (result) {
      Ok(value: final model) => Result.ok(model),
      Error(message: final e) => Result.error(e),
    };
  }

  @override
  Future<Result<RegistredUserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    return switch (result) {
      Ok(value: final model) => Result.ok(model), // أو .toEntity()
      Error(message: final e) => Result.error(e),
    };
  }
}
