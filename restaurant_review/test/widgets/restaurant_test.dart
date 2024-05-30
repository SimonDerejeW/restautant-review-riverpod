import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/description_chips.dart';
import 'package:restaurant_review/presentation/widgets/restaurant.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_home_image.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_statue_open.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_status_closed.dart';

void main() {
  testWidgets('Restaurant widget displays correctly when status is open',
      (WidgetTester tester) async {
    // Define test data
    const String testImagePath = 'assets/burger.jpg';
    const String testRestaurantName = 'Test Restaurant';
    const String testStatus = 'open';
    final List<String> testChipsList = ['Chip 1', 'Chip 2'];

    // Build the Restaurant widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Restaurant(
            imagePath: testImagePath,
            restaurantName: testRestaurantName,
            status: testStatus,
            chipsList: testChipsList,
          ),
        ),
      ),
    );

    // Find elements in the Restaurant widget
    final imageFinder = find.byType(RestaurantHomeImage);
    final nameFinder = find.text(testRestaurantName);
    final openFinder = find.byType(RestaurantOpen);
    final chipsFinder = find.byType(RestaurantChips);

    // Verify the elements are found
    expect(imageFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
    expect(openFinder, findsOneWidget);
    expect(chipsFinder, findsWidgets);
  });

  testWidgets('Restaurant widget displays correctly when status is closed',
      (WidgetTester tester) async {
    // Define test data
    const String testImagePath = 'assets/burger.jpg';
    const String testRestaurantName = 'Test Restaurant';
    const String testStatus = 'closed';
    final List<String> testChipsList = ['Chip 1', 'Chip 2'];

    // Build the Restaurant widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Restaurant(
            imagePath: testImagePath,
            restaurantName: testRestaurantName,
            status: testStatus,
            chipsList: testChipsList,
          ),
        ),
      ),
    );

    // Find elements in the Restaurant widget
    final imageFinder = find.byType(RestaurantHomeImage);
    final nameFinder = find.text(testRestaurantName);
    final closedFinder = find.byType(RestaurantClosed);
    final chipsFinder = find.byType(RestaurantChips);

    // Verify the elements are found
    expect(imageFinder, findsOneWidget);
    expect(nameFinder, findsOneWidget);
    expect(closedFinder, findsOneWidget);
    expect(chipsFinder, findsWidgets);
  });
}
