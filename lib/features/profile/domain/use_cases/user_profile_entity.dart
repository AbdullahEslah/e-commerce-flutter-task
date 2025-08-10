import 'package:ecommerce_app/features/profile/domain/entites/device_info_entity.dart';
import 'package:ecommerce_app/features/profile/domain/entites/user_profile_entity.dart';
import 'package:ecommerce_app/features/profile/domain/repository/user_profile_repository.dart';

import '../../../../core/utils/network_utils/network_service.dart';

class UserProfileUseCase {
  final UserProfileRepository userProfileRepository;

  const UserProfileUseCase(this.userProfileRepository);

  Future<Result<UserProfileEntity>> fetchUserProfile() async {
    return await userProfileRepository.fetchUserProfile();
  }

  Future<DeviceInfoEntity?> fetchDeviceInfo() async {
    return await userProfileRepository.fetchDeviceInfo();
  }
}
