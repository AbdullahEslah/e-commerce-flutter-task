import 'package:ecommerce_app/features/profile/data/models/user_profile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/apis.dart';
import '../../../../core/constants/endpoint_enum.dart';
import '../../../../core/utils/network_utils/network_service.dart';
import '../../domain/entites/device_info_entity.dart';

abstract class UserProfileRemoteDataSource {
  Future<Result<UserProfileResponseModel>> fetchUserProfile();
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final SharedPreferences sharedPreferences;
  const UserProfileRemoteDataSourceImpl(this.sharedPreferences);
  @override
  Future<Result<UserProfileResponseModel>> fetchUserProfile() async {
    final request = await NetworkService().request<UserProfileResponseModel>(
        url: Apis.getEndPointPath(EndPointsEnum.userProfile),
        method: HttpMethod.get,
        headers: {
          "Authorization":
              "Bearer ${sharedPreferences.getString("accessToken") ?? ""}"
        },
        fromJson: (data) => UserProfileResponseModel.fromJson(data));
    return request;
  }
}
