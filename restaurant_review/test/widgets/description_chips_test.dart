import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/core/theme/app_pallete.dart';
import 'package:restaurant_review/presentation/widgets/description_chips.dart';

void main() {
  testWidgets('RestaurantChips displays the correct label text',
      (WidgetTester tester) async {
    const testLabelText = 'Test Chip';

    // Build the RestaurantChips widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RestaurantChips(labelText: testLabelText),
        ),
      ),
    );

    // Verify that the Chip contains the correct label text
    expect(find.text(testLabelText), findsOneWidget);
  });

  testWidgets('RestaurantChips applies correct styles',
      (WidgetTester tester) async {
    const testLabelText = 'Test Chip';

    // Build the RestaurantChips widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RestaurantChips(labelText: testLabelText),
        ),
      ),
    );

    // Find the Chip widget
    final chipFinder = find.byType(Chip);
    expect(chipFinder, findsOneWidget);

    // Verify the Chip's background color
    final chipWidget = tester.widget<Chip>(chipFinder);
    expect(chipWidget.backgroundColor, AppPallete.greyColor);

    // Verify the Chip's label text style
    final textFinder = find.text(testLabelText);
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style?.color, Colors.white);
    expect(textWidget.style?.fontSize, 12);
  });
}
