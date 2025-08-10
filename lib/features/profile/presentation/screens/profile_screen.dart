import 'package:ecommerce_app/core/utils/extenions/navigation_extension.dart';
import 'package:ecommerce_app/features/authentication/presentation/screens/auth_screen.dart';
import 'package:ecommerce_app/features/profile/presentation/provider/user_profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enum_state/device_info_enum_state.dart';
import '../enum_state/user_profile_enum_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget loadCurrentWidget(
      UserProfileProvider userProfileProvider, BuildContext context) {
    switch (userProfileProvider.userProfileState) {
      case UserProfileEnumState.normal:
        return buildMainView(userProfileProvider);

      case UserProfileEnumState.loading:
        return const Center(
          child: CupertinoActivityIndicator(color: Colors.black54, radius: 15),
        );

      case UserProfileEnumState.success:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          userProfileProvider.resetUserProfileState();
        });
        break;

      case UserProfileEnumState.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                userProfileProvider.errorMessage ?? "",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
          userProfileProvider.resetUserProfileState();
        });
        return Center(
          child: Text(
            userProfileProvider.errorMessage ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
    }

    switch (userProfileProvider.deviceInfoState) {
      case DeviceInfoEnumState.normal:
        return buildMainView(userProfileProvider);

      case DeviceInfoEnumState.loading:
        return const Center(
          child: CupertinoActivityIndicator(color: Colors.black54, radius: 15),
        );

      case DeviceInfoEnumState.success:
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          userProfileProvider.resetUserProfileState();
        });
        return buildMainView(userProfileProvider);

      case DeviceInfoEnumState.error:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                userProfileProvider.errorMessage ?? "",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
          userProfileProvider.resetUserProfileState();
        });
        return Center(
          child: Text(
            userProfileProvider.errorMessage ?? "",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  Padding buildMainView(UserProfileProvider userProfileProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 32,
        children: [
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                spacing: 16,
                children: [
                  Text(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      "Name"),
                  Text(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      "Email"),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                        style: TextStyle(color: Colors.black),
                        userProfileProvider.userProfileData?.name ?? ""),
                    Text(
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                        userProfileProvider.userProfileData?.email ?? ""),
                  ])
            ],
          ),
          Divider(),
          Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      "Device Model"),
                  Text(
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      "Device System Version"),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                        style: TextStyle(color: Colors.black),
                        userProfileProvider.deviceInfoEntity?.model ?? ""),
                    Text(
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                        userProfileProvider.deviceInfoEntity?.systemVersion ??
                            ""),
                  ])
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserProfileProvider userProfileProvider =
        Provider.of<UserProfileProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            toolbarHeight: MediaQuery.sizeOf(context).height * 0.125,
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 8.0, end: 8.0, bottom: 4, top: 4),
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        iconSize: 22,
                        color: Colors.red[900],
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          await sharedPreferences.remove("accessToken");
                          await sharedPreferences.remove("name");

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.pushAndRemoveAll(const AuthScreen());
                          });
                          debugPrint(
                              "accessToken from sharedPref is ${sharedPreferences.getString("accessToken")}");
                          debugPrint(
                              "name from sharedPref is ${sharedPreferences.getString("name")}");
                        },
                        icon: Icon(Icons.logout),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.red[900],
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ],
            title: Text(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                "Profile"),
          ),
        ),
        body: loadCurrentWidget(userProfileProvider, context));
  }
}
