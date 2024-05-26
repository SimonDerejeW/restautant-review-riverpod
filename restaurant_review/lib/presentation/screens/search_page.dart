import 'package:flutter/material.dart';
import 'package:restaurant_review/presentation/widgets/search_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(20),
      child: SearchWidget(),
      ),
    );
  }
}