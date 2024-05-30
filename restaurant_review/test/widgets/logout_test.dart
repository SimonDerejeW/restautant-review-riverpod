import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/logout.dart';

void main() {
  testWidgets('LogOut widget displays icon and text correctly',
      (WidgetTester tester) async {
    // Build the LogOut widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LogOut(),
        ),
      ),
    );

    // Find the Icon and Text widgets
    final iconFinder = find.byIcon(Icons.logout);
    final textFinder = find.text('Log Out');

    // Verify the Icon and Text widgets' properties
    expect(iconFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);

    // Verify the Text widget's style
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style!.fontSize, 15);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
  });
}
