import 'package:ecommerce_app/features/profile/domain/entites/user_profile_entity.dart';
import 'package:ecommerce_app/features/profile/domain/use_cases/user_profile_entity.dart';
import 'package:ecommerce_app/features/profile/presentation/enum_state/device_info_enum_state.dart';
import 'package:ecommerce_app/features/profile/presentation/enum_state/user_profile_enum_state.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/network_utils/network_service.dart';
import '../../domain/entites/device_info_entity.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfileProvider(this.userProfileUseCase) {
    fetchUserProfile();
    fetchDeviceInfo();
  }

  final UserProfileUseCase userProfileUseCase;

  /// responsible for showing errorMessage
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  /// responsible for loading, failure or success state
  UserProfileEnumState _userProfileState = UserProfileEnumState.normal;

  UserProfileEnumState get userProfileState => _userProfileState;

  DeviceInfoEnumState _deviceInfoState = DeviceInfoEnumState.normal;

  DeviceInfoEnumState get deviceInfoState => _deviceInfoState;

  /// products list
  UserProfileEntity? _userProfileData;
  UserProfileEntity? get userProfileData => _userProfileData;

  DeviceInfoEntity? _deviceInfoEntity;
  DeviceInfoEntity? get deviceInfoEntity => _deviceInfoEntity;

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  //  update products screen state
  void setUserProfileState(UserProfileEnumState state) {
    _userProfileState = state;
    notifyListeners();
  }

  // Reset screen to normal state
  void resetUserProfileState() {
    _userProfileState = UserProfileEnumState.normal;
    notifyListeners();
  }

  void setDeviceInfoState(DeviceInfoEnumState state) {
    _deviceInfoState = state;
    notifyListeners();
  }

  void resetDeviceInfoState() {
    _deviceInfoState = DeviceInfoEnumState.normal;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    setUserProfileState(UserProfileEnumState.loading);
    Future.delayed(Duration(seconds: 2));
    final result = await userProfileUseCase.fetchUserProfile();

    switch (result) {
      case Ok(value: final userProfileData):
        debugPrint("$userProfileData");
        _userProfileData = userProfileData;
        setUserProfileState(UserProfileEnumState.success);
        break;

      case Error(message: final e):
        debugPrint(e);
        setError(e.toString());
        setUserProfileState(UserProfileEnumState.error);
        break;
    }
  }

  Future<DeviceInfoEntity?> fetchDeviceInfo() async {
    setDeviceInfoState(DeviceInfoEnumState.loading);
    Future.delayed(Duration(seconds: 2));
    try {
      _deviceInfoEntity = await userProfileUseCase.fetchDeviceInfo();
      setDeviceInfoState(DeviceInfoEnumState.success);
    } catch (e) {
      _deviceInfoEntity = null;
      debugPrint("error in fetching device info $e");
      setError(e.toString());
      setDeviceInfoState(DeviceInfoEnumState.error);
    }
    return _deviceInfoEntity;
  }
}
