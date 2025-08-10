import 'package:ecommerce_app/features/authentication/domain/entities/register/registred_user_entity.dart';

class RegistredUserResponseModel extends RegistredUserEntity {
  const RegistredUserResponseModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory RegistredUserResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistredUserResponseModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
