import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: bottomNavProvider.screensList?[bottomNavProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        unselectedItemColor: const Color(0xFFA59490),
        currentIndex: bottomNavProvider.currentIndex,
        onTap: bottomNavProvider.changeIndex,
        unselectedIconTheme: IconThemeData(size: 25, applyTextScaling: true),
        selectedIconTheme: IconThemeData(size: 30, applyTextScaling: true),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
