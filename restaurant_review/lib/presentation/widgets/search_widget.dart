import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top:10),
      padding: const EdgeInsets.only(left: 20, right: 20, top:10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Restaurants...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
