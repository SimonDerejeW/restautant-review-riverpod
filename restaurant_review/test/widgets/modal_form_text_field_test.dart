import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/modal_form_text_field.dart'; // Update file path as necessary

void main() {
  testWidgets('TextFieldWLabel widget displays label and asterisk correctly',
      (WidgetTester tester) async {
    // Define test data
    const String testLabel = 'Name';
    const bool testRequired = true;

    // Build the TextFieldWLabel widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TextFieldWLabel(
            label: testLabel,
            required: testRequired,
          ),
        ),
      ),
    );

    // Find the Text widgets for label and asterisk
    final labelFinder = find.text(testLabel);
    final asteriskFinder = find.text('*');

    // Verify the Text widgets' properties
    expect(labelFinder, findsOneWidget);
    expect(asteriskFinder, findsOneWidget);

    // Verify the label style
    final labelWidget = tester.widget<Text>(labelFinder);
    expect(labelWidget.style!.fontSize, 14);
    expect(labelWidget.style!.fontWeight, FontWeight.bold);

    // Verify the asterisk style
    final asteriskWidget = tester.widget<Text>(asteriskFinder);
    expect(asteriskWidget.style!.color, Colors.red);
  });

  testWidgets(
      'TextFieldWLabel widget displays without asterisk when not required',
      (WidgetTester tester) async {
    // Define test data
    const String testLabel = 'Name';
    const bool testRequired = false;

    // Build the TextFieldWLabel widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: TextFieldWLabel(
            label: testLabel,
            required: testRequired,
          ),
        ),
      ),
    );

    // Find the Text widgets for label and asterisk
    final labelFinder = find.text(testLabel);
    final asteriskFinder = find.text('*');

    // Verify the Text widgets' properties
    expect(labelFinder, findsOneWidget);
    expect(asteriskFinder, findsNothing);
  });
}
