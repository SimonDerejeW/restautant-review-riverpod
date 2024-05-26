

import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/theme.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/screens/Restaurant_page.dart';
import 'package:restaurant_review/presentation/screens/admin_tab.dart';
import 'package:restaurant_review/presentation/screens/bottom_nav.dart';
import 'package:restaurant_review/presentation/screens/home_page.dart';
import 'package:restaurant_review/presentation/screens/search_page.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.LightThemeMode,
      home: SignUpPage(),
      routes: {
        '/firstpage' : (context) => ReviewHome(),
        '/searchpage' : (context) => SearchPage(),
        '/profilepage' :(context) => ProfilePage(),
        "/restaurantpage" :(context) => RestaurantPage(),
        '/adminprofile' :(context) => AdminTab(),
        "/entry" :(context) => BottomNav()
      },
    );
  }
}
