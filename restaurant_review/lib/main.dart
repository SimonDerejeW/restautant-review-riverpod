import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/core/theme/theme.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/screens/Restaurant_page.dart';
import 'package:restaurant_review/presentation/screens/admin_tab.dart';
import 'package:restaurant_review/presentation/screens/bottom_nav.dart';
import 'package:restaurant_review/presentation/screens/home_page.dart';
import 'package:restaurant_review/presentation/screens/search_page.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';


void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.LightThemeMode,
        home: const SignUpPage(),
        routes: {
          '/firstpage': (context) => const ReviewHome(),
          '/searchpage': (context) => const SearchPage(),
          '/profilepage': (context) => ProfilePage(),
          "/restaurantpage": (context) => RestaurantPage(),
          '/adminprofile': (context) => const AdminTab(),
          "/entry": (context) => const BottomNav(),
        },
      ),
    );
  }
}
