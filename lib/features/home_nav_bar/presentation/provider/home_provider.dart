import 'dart:collection';

import 'package:ecommerce_app/features/products/presentation/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../../../favorites/presentation/sceens/favorites_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';

class HomeProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<Widget> _screens = <Widget>[
    const ProductsScreen(),
    const FavoritesScreen(),
    const ProfileScreen()
  ];
  UnmodifiableListView<Widget>? get screensList {
    return UnmodifiableListView(_screens ?? []);
  }

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
