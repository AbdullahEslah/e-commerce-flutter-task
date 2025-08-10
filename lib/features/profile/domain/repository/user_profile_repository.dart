import 'package:ecommerce_app/features/profile/domain/entites/device_info_entity.dart';
import 'package:ecommerce_app/features/profile/domain/entites/user_profile_entity.dart';

import '../../../../core/utils/network_utils/network_service.dart';

abstract class UserProfileRepository {
  Future<Result<UserProfileEntity>> fetchUserProfile();
  Future<DeviceInfoEntity?> fetchDeviceInfo();
}
