import 'package:flutter/material.dart';
import 'package:restaurant_review/core/theme/theme.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/screens/Restaurant_page.dart';
import 'package:restaurant_review/presentation/screens/admin_tab.dart';
import 'package:restaurant_review/presentation/screens/bottom_nav.dart';
import 'package:restaurant_review/presentation/screens/home_page.dart';
import 'package:restaurant_review/presentation/screens/login_in_page.dart';
import 'package:restaurant_review/presentation/screens/search_page.dart';
import 'package:restaurant_review/presentation/screens/sign_up_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


final _router = GoRouter(
  initialLocation: "/signup",
  routes: [
    GoRoute(
      name: "signup",
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),

    GoRoute(
      name: "login",
      path: '/login',
      builder: (context, state) => LogInPage(),
    ),

    GoRoute(
      name: "home",
      path: '/home',
      builder: (context, state) => BottomNav(),
    ),

    GoRoute(
      name: '/restaurantpage',
      path: '/restaurantpage/:id',
      builder: (context, state) { return RestaurantPage(restaurantId: state.pathParameters["id"] as String);},
    )
  ]
);





void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.LightThemeMode,
      // home: const SignUpPage(),
      // routes: {
      //   '/firstpage': (context) => const ReviewHome(),
      //   '/searchpage': (context) => const SearchPage(),
      //   '/profilepage': (context) => ProfilePage(),
      //   // "/restaurantpage": (context) => RestaurantPage(),
      //   '/adminprofile': (context) => const AdminTab(),
      //   "/entry": (context) => const BottomNav(),
      //   "/logines": (context) => const LogInPage()
      // },
      routerConfig: _router,
    );
  }
}
