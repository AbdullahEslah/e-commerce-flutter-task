import 'endpoint_enum.dart';

class Apis {
  static final baseUrl = "https://api.escuelajs.co/api/v1/";

  /// authentication
  static const registerUser = "users";
  static const loginUser = "auth/login";

  /// home
  static const products = "products";

  /// user-profile
  static const userProfile = "auth/profile";
  static const refreshTokenForUserProfile = "auth/refresh-token";

  /// concatenate baseurl with endpoints
  static String getEndPointPath(EndPointsEnum endpoint) {
    switch (endpoint) {
      case EndPointsEnum.registerUser:
        return baseUrl + registerUser;

      case EndPointsEnum.loginUser:
        return baseUrl + loginUser;

      case EndPointsEnum.products:
        return baseUrl + products;

      case EndPointsEnum.userProfile:
        return baseUrl + userProfile;

      case EndPointsEnum.refreshTokenForUserProfile:
        return baseUrl + refreshTokenForUserProfile;
    }
  }
}
