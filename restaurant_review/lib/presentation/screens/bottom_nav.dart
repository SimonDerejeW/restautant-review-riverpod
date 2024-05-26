import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/screens/Profile_page.dart';
import 'package:restaurant_review/presentation/screens/home_page.dart';
import 'package:restaurant_review/presentation/screens/search_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
    //Create variable for selected index on the bottom nav bar
  int selected_idx = 0;

  void _navigateBottomBar (int index){
    setState(() {
      selected_idx = index;
    });
  }

  List _pages = [
    ReviewHome(),
    SearchPage(),
    ProfilePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selected_idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected_idx,
        onTap: _navigateBottomBar,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
            ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          )



            ],
      ),
    );
  }
}