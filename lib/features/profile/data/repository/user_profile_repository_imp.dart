import 'package:ecommerce_app/core/utils/network_utils/network_service.dart';
import 'package:ecommerce_app/features/profile/data/remote_data_source/user_profile_remote_data_source.dart';
import 'package:ecommerce_app/features/profile/domain/entites/device_info_entity.dart';
import 'package:ecommerce_app/features/profile/domain/entites/user_profile_entity.dart';
import 'package:ecommerce_app/features/profile/domain/repository/user_profile_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class UserProfileRepositoryImp implements UserProfileRepository {
  final UserProfileRemoteDataSource userProfileRemoteDataSource;
  static const _channel = MethodChannel('com.example/device_info');

  const UserProfileRepositoryImp(this.userProfileRemoteDataSource);

  @override
  Future<Result<UserProfileEntity>> fetchUserProfile() async {
    return await userProfileRemoteDataSource.fetchUserProfile();
  }

  @override
  Future<DeviceInfoEntity?> fetchDeviceInfo() async {
    Map<dynamic, dynamic>? result;

    result =
        await _channel.invokeMethod<Map<dynamic, dynamic>>('fetchDeviceInfo');

    if (result != null) {
      return DeviceInfoEntity(
        model: result['model'] ?? "",
        systemVersion: result['systemVersion'] ?? "",
      );
    } else {
      return null;
    }
  }
}
