import 'package:ecommerce_app/core/utils/extenions/navigation_extension.dart';
import 'package:ecommerce_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:ecommerce_app/features/home_nav_bar/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/validation_utils/validation.dart';
import '../../../../custom_widgets/custom_text_form_field.dart';
import '../state_enums/login_enum_state/login_enum_state.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static final GlobalKey<FormState> mainWidgetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: screenHeight * 0.09,
            title: Text(
              (authProvider.registerButtonTapped ?? false)
                  ? "Register"
                  : "Login",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: loadWidget(authProvider, context)),
        ));
  }

  SingleChildScrollView buildAuthFields(
      AuthProvider authProvider, BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return SingleChildScrollView(
      child: Form(
        key: mainWidgetFormKey,
        child: Padding(
          padding: EdgeInsets.only(
              left: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
              right: 16),
          child: Column(
            spacing: 16,
            children: [
              Column(
                children: [
                  Visibility(
                    visible: (authProvider.registerButtonTapped == true),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        CustomTextFieldForm(
                          controller: authProvider.nameTextEditController,
                          onChanged: (fromChanged) =>
                              authProvider.updateNameTextField(fromChanged),
                          keyboardType: TextInputType.name,
                          placeholder: "Name",
                          emptyValueText: 'Please type your name',
                          // focus: nameFocus,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomTextFieldForm(
                    keyboardType: TextInputType.emailAddress,
                    controller: authProvider.emailTextEditController,
                    onChanged: (idChanged) =>
                        authProvider.updateEmailTextField(idChanged),
                    placeholder: "Email Address",
                    emptyValueText: 'please type your email address',
                    // focus: idNumberFocus,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      "Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomTextFieldForm(
                    secureText: true,
                    keyboardType: TextInputType.text,
                    controller: authProvider.passwordTextEditController,
                    onChanged: (password) =>
                        authProvider.updatePasswordTextField(password),
                    placeholder: "Password",
                    emptyValueText: 'please type your password',
                    // focus: idNumberFocus,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      if (authProvider.registerButtonTapped == true) {
                        if (mainWidgetFormKey.currentState?.validate() ??
                            false) {
                          bool? isEmailValid = Validation.validateEmail(
                              authProvider.emailTextEditController?.text);
                          if (isEmailValid == false) {
                            //  not valid email address
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "please type valid email address",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                            return;
                          }
                          String? isValidPassword = Validation.validatePassword(
                              authProvider.passwordTextEditController?.text);
                          if (isValidPassword != "valid") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isValidPassword ?? "",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                            return;
                          }

                          /// register after validation
                          authProvider.register(context);
                        }
                      } else {
                        //  login
                        if (mainWidgetFormKey.currentState?.validate() ??
                            false) {
                          bool? isEmailValid = Validation.validateEmail(
                              authProvider.emailTextEditController?.text);
                          if (isEmailValid == false) {
                            //  not valid email address
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "please type valid email address",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                            return;
                          }
                          String? isValidPassword = Validation.validatePassword(
                              authProvider.passwordTextEditController?.text);
                          if (isValidPassword != "valid") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isValidPassword ?? "",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                            return;
                          }

                          /// login after validation
                          authProvider.login();
                        }
                      }
                    },
                    child: Text(
                      (authProvider.registerButtonTapped == true)
                          ? "Register"
                          : "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Text(
                      (authProvider.registerButtonTapped == true)
                          ? "Already have an account ?"
                          : "Don't Have An Account!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    TextButton(
                      onPressed: () {
                        if (authProvider.registerButtonTapped == true) {
                          authProvider.resetRegisterButton(); // يخليها false
                        } else {
                          authProvider.clickOnRegisterButton(); // يخليها true
                        }
                      },
                      child: Text(
                        (authProvider.registerButtonTapped == true)
                            ? "Login"
                            : "Register",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ])
            ],
          ),
        ),
      ),
    );
  }

  Widget loadWidget(AuthProvider authProvider, BuildContext context) {
    if (authProvider.registerButtonTapped == true) {
      switch (authProvider.authState) {
        case AuthEnumState.normal:
          return buildAuthFields(authProvider, context);

        case AuthEnumState.loading:
          return const Center(
            child:
                CupertinoActivityIndicator(color: Colors.black54, radius: 15),
          );

        case AuthEnumState.success:
          break;
        // WidgetsBinding.instance.addPostFrameCallback((_) async {
        // authProvider.resetAuthUserState();
        // await authProvider.login();
        // });
        //return const SizedBox.shrink(); // <-- مهم جدًا

        case AuthEnumState.error:
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  authProvider.errorMessage ?? "",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
            authProvider.resetAuthUserState();
          });
          return buildAuthFields(authProvider, context);
      }
    }

    // Login state switch
    switch (authProvider.authState) {
      case AuthEnumState.normal:
        return buildAuthFields(authProvider, context);

      case AuthEnumState.loading:
        return const Center(
          child: CupertinoActivityIndicator(color: Colors.black54, radius: 15),
        );

      case AuthEnumState.success:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.pushAndRemoveAll(const HomeScreen());
          authProvider.resetAuthUserState();
          authProvider.resetAuthFields();
        });
        return const SizedBox.shrink();

      case AuthEnumState.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                authProvider.errorMessage ?? "",
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
          authProvider.resetAuthUserState();
        });
        return buildAuthFields(authProvider, context);
    }
  }
}
