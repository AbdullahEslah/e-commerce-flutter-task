import 'package:ecommerce_app/core/utils/extenions/navigation_extension.dart';
import 'package:ecommerce_app/features/authentication/domain/use_cases/login/login_use_case.dart';
import 'package:ecommerce_app/features/authentication/presentation/state_enums/login_enum_state/login_enum_state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/network_utils/network_service.dart';
import '../../../home_nav_bar/presentation/screens/home_screen.dart';
import '../../domain/use_cases/register/register_use_case.dart';
import '../state_enums/register_enum_state/register_enum_state.dart';

class AuthProvider with ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SharedPreferences sharedPreferences;

  AuthProvider(this.loginUseCase, this.registerUseCase, this.sharedPreferences);

  /// for showing and hiding nameTextField
  bool? _registerButtonTapped;
  bool? get registerButtonTapped => _registerButtonTapped;

  /// auth screens textFields
  final TextEditingController _nameTextEditController = TextEditingController();
  TextEditingController? get nameTextEditController => _nameTextEditController;

  final TextEditingController _emailTextEditController =
      TextEditingController();
  TextEditingController? get emailTextEditController =>
      _emailTextEditController;

  final TextEditingController _passwordTextEditController =
      TextEditingController();
  TextEditingController? get passwordTextEditController =>
      _passwordTextEditController;

  /// responsible for showing errorMessage
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// responsible for loading, failure or success state
  // RegisterEnumState _registerState = RegisterEnumState.normal;
  // RegisterEnumState get registerState => _registerState;

  AuthEnumState _authState = AuthEnumState.normal;
  AuthEnumState get authState => _authState;

  Future<void> clickOnRegisterButton() async {
    _registerButtonTapped = true;
    notifyListeners();
  }

  Future<void> resetRegisterButton() async {
    _registerButtonTapped = false;
    notifyListeners();
  }

  void setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  //  update register screen state
  // void setRegisterUserState(RegisterEnumState state) {
  //   _registerState = state;
  //   notifyListeners();
  // }

  // Reset to normal state
  // void resetRegisterUserState() {
  //   _registerState = RegisterEnumState.normal;
  //   notifyListeners();
  // }

  //  update register screen state
  void setAuthUserState(AuthEnumState state) {
    _authState = state;
    notifyListeners();
  }

  // Reset to normal state
  void resetAuthUserState() {
    _authState = AuthEnumState.normal;
    notifyListeners();
  }

  void updateNameTextField(String name) {
    _nameTextEditController.text = name;
    notifyListeners();
  }

  void updateEmailTextField(String email) {
    _emailTextEditController.text = email;
    notifyListeners();
  }

  void updatePasswordTextField(String password) {
    _passwordTextEditController.text = password;
    notifyListeners();
  }

  void resetAuthFields() {
    _nameTextEditController.clear();
    _emailTextEditController.clear();
    _passwordTextEditController.clear();
    notifyListeners();
  }

  Future<bool> register(BuildContext context) async {
    bool? isRegistredAndLoggedSuccessfully;
    setAuthUserState(AuthEnumState.loading);
    await Future.delayed(Duration(seconds: 2));
    final result = await registerUseCase.register(_emailTextEditController.text,
        _passwordTextEditController.text, _nameTextEditController.text);

    switch (result) {
      case Ok(value: final t):
        await sharedPreferences.setString("name", t.name);
        await sharedPreferences.setString("email", t.email);

        isRegistredAndLoggedSuccessfully = true;
        await login();
        setAuthUserState(AuthEnumState.success);

      case Error(message: final e):
        setError(e.toString());
        setAuthUserState(AuthEnumState.error);
        isRegistredAndLoggedSuccessfully = false;
    }
    return isRegistredAndLoggedSuccessfully;
  }

  Future<bool> login() async {
    setAuthUserState(AuthEnumState.loading);
    await Future.delayed(Duration(seconds: 2));

    final result = await loginUseCase.login(
        _emailTextEditController.text, _passwordTextEditController.text);

    switch (result) {
      case Ok(value: final t):
        await sharedPreferences.setString("accessToken", t.accessToken);
        await sharedPreferences.setString("refreshToken", t.refreshToken);
        setAuthUserState(AuthEnumState.success);
        return true;

      case Error(message: final e):
        if (e == "Unauthorized") {
          setError("Unable To Login With Provided Credentials");
        } else {
          setError(e.toString());
        }
        setAuthUserState(AuthEnumState.error);
        return false;
    }
  }

  @override
  void dispose() {
    _emailTextEditController.dispose();
    _passwordTextEditController.dispose();
    _nameTextEditController.dispose();
    super.dispose();
  }
}
