import 'package:ecommerce_app/features/authentication/data/remote_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/authentication/data/repository/auth_repository_implementation.dart';
import 'package:ecommerce_app/features/authentication/domain/use_cases/login/login_use_case.dart';
import 'package:ecommerce_app/features/authentication/domain/use_cases/register/register_use_case.dart';
import 'package:ecommerce_app/features/authentication/presentation/provider/auth_provider.dart';
import 'package:ecommerce_app/features/authentication/presentation/screens/auth_screen.dart';
import 'package:ecommerce_app/features/home_nav_bar/presentation/screens/home_screen.dart';
import 'package:ecommerce_app/features/products/data/remote_data_source/products_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/repository/products_repository_impl.dart';
import 'package:ecommerce_app/features/products/domain/use_case/products_use_case.dart';
import 'package:ecommerce_app/features/products/presentation/provider/products_provider.dart';
import 'package:ecommerce_app/features/profile/data/remote_data_source/user_profile_remote_data_source.dart';
import 'package:ecommerce_app/features/profile/data/repository/user_profile_repository_imp.dart';
import 'package:ecommerce_app/features/profile/domain/use_cases/user_profile_entity.dart';
import 'package:ecommerce_app/features/profile/presentation/provider/user_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home_nav_bar/presentation/provider/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPref = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: sharedPref));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  Future<bool> checkAccessToken() async {
    // if ((await prefs.getString("accessToken") == null ||
    //         await prefs.getString("accessToken")?.isEmpty == true) &&
    //     ((await prefs.getString("name") != null &&
    //         await prefs.getString("name")?.isNotEmpty == true))) {
    //   //  then send login request
    // }
    if
        // (
        (await prefs.getString("accessToken") != null &&
            await prefs.getString("accessToken")?.isNotEmpty == true)
    // ||
    // (await prefs.getString("name") != null &&
    //     await prefs.getString("name")?.isNotEmpty == true))
    {
      return true;
    } else {
      return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// auth provider
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            LoginUseCase(AuthRepositoryImplementation(
                AuthRemoteDataSourceImplementation())),
            RegisterUseCase(AuthRepositoryImplementation(
                AuthRemoteDataSourceImplementation())),
            prefs,
          ),
        ),

        /// home provider
        ChangeNotifierProvider(create: (_) => HomeProvider()),

        /// products provider
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(
            ProductsUseCase(
                ProductsRepositoryImpl(ProductsRemoteDataSourceImpl())),
          ),
        ),

        /// profile provider
        ChangeNotifierProvider(
          create: (_) => UserProfileProvider(
            UserProfileUseCase(UserProfileRepositoryImp(
                UserProfileRemoteDataSourceImpl(prefs))),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce App',
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Color(0xFFE4D0CC)),
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          //F6DDCC
          scaffoldBackgroundColor: const Color(0xFFE4D0CC),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: checkAccessToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.data == true) {
              return const HomeScreen();
            } else {
              return const AuthScreen();
            }
          },
        ),
      ),
    );
  }
}
