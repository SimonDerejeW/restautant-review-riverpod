import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/buttons.dart';

void main() {
  testWidgets('Buttons widget displays text and background color correctly',
      (WidgetTester tester) async {
    // Define test data
    const String testButtonText = 'Test Button';
    const Color testButtonColor = Colors.blue;

    // Build the Buttons widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Buttons(
            text: testButtonText,
            backgroundColor: testButtonColor,
            onPressed: () {}, // Provide a dummy onPressed callback
          ),
        ),
      ),
    );

    // Find the ElevatedButton widget
    final buttonFinder = find.byType(ElevatedButton);

    // Verify the ElevatedButton widget's properties
    expect(buttonFinder, findsOneWidget);
    final elevatedButtonWidget = tester.widget<ElevatedButton>(buttonFinder);
    expect(elevatedButtonWidget.style!.backgroundColor!.resolve({}),
        testButtonColor);

    // Find the Text widget
    final textFinder = find.text(testButtonText);

    // Verify the Text widget's properties
    expect(textFinder, findsOneWidget);
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.data, testButtonText);
    expect(textWidget.style!.color, Colors.white);
    expect(textWidget.style!.fontSize, 12);
  });
}
