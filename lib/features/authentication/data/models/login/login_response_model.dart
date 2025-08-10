import 'package:ecommerce_app/features/authentication/domain/entities/login/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  const LoginResponseModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
