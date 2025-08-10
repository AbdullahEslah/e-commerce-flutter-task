import 'package:ecommerce_app/core/constants/endpoint_enum.dart';
import 'package:ecommerce_app/features/authentication/data/models/login/login_response_model.dart';
import 'package:ecommerce_app/features/authentication/data/models/register/registred_user_response_model.dart';

import '../../../../core/constants/apis.dart';
import '../../../../core/utils/network_utils/network_service.dart';

abstract class AuthRemoteDataSource {
  Future<Result<RegistredUserResponseModel>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Result<LoginResponseModel>> login(
      {required String email, required String password});
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  @override
  Future<Result<RegistredUserResponseModel>> register(
      {required String name,
      required String email,
      required String password}) async {
    final request = await NetworkService().request<RegistredUserResponseModel>(
        url: Apis.getEndPointPath(EndPointsEnum.registerUser),
        method: HttpMethod.post,
        parameters: {
          "avatar": "https://picsum.photos/800",
          "email": email,
          "password": password,
          "name": name
        },
        fromJson: (data) => RegistredUserResponseModel.fromJson(data));
    return request;
  }

  @override
  Future<Result<LoginResponseModel>> login(
      {required String email, required String password}) async {
    final request = await NetworkService().request<LoginResponseModel>(
        url: Apis.getEndPointPath(EndPointsEnum.loginUser),
        method: HttpMethod.post,
        parameters: {
          "email": email,
          "password": password,
        },
        fromJson: (data) => LoginResponseModel.fromJson(data));

    return request;
  }
}
