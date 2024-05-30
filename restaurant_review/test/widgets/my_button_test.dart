import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/my_button.dart';

void main() {
  testWidgets(
      'MyDialogButton widget displays text and triggers onPressed callback',
      (WidgetTester tester) async {
    // Define test data
    const String testText = 'Confirm';
    bool onPressedCalled = false;

    // Build the MyDialogButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyDialogButton(
            text: testText,
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    // Find the MaterialButton widget
    final buttonFinder = find.byType(MaterialButton);

    // Verify the MaterialButton widget's properties
    expect(buttonFinder, findsOneWidget);
    final buttonWidget = tester.widget<MaterialButton>(buttonFinder);
    expect(buttonWidget.color, const Color.fromARGB(255, 245, 149, 24));
    expect(find.text(testText), findsOneWidget);

    // Tap the button
    await tester.tap(buttonFinder);
    await tester.pump();

    // Verify that onPressed callback is triggered
    expect(onPressedCalled, true);
  });
}
