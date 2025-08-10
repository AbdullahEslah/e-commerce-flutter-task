import 'package:ecommerce_app/features/profile/domain/entites/user_profile_entity.dart';

class UserProfileResponseModel extends UserProfileEntity {
  const UserProfileResponseModel(
      {required super.id, required super.email, required super.name});

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UserProfileResponseModel(
        id: json["id"],
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "name": name,
    };
  }
}
