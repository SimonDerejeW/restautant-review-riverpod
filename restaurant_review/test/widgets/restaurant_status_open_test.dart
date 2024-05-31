import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_statue_open.dart';

void main() {
  testWidgets('RestaurantOpen widget displays "Open" text in green bold font',
      (WidgetTester tester) async {
    // Build the RestaurantOpen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RestaurantOpen(),
        ),
      ),
    );

    // Find the Text widget
    final textFinder = find.text('Open');

    // Verify the Text widget's properties
    expect(textFinder, findsOneWidget);
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style!.color, AppPallete.greenColor);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
  });
}
