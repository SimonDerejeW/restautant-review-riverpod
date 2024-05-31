import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_status_closed.dart';

void main() {
  testWidgets('RestaurantClosed widget displays "Closed" text in red bold font',
      (WidgetTester tester) async {
    // Build the RestaurantClosed widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RestaurantClosed(),
        ),
      ),
    );

    // Find the Text widget
    final textFinder = find.text('Closed');

    // Verify the Text widget's properties
    expect(textFinder, findsOneWidget);
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style!.color, AppPallete.redColor);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
  });
}
