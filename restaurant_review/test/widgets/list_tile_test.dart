import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/list_tile.dart';

void main() {
  testWidgets('list_tile widget displays title and leading icon correctly', (WidgetTester tester) async {
    // Define test data
    const String testTitle = 'List Tile';
    final Icon testLeadingIcon = Icon(Icons.access_alarm);

    // Build the list_tile widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: list_tile(
            title: testTitle,
            leading: testLeadingIcon,
          ),
        ),
      ),
    );

    // Find the Icon and Text widgets
    final iconFinder = find.byIcon(Icons.access_alarm);
    final textFinder = find.text('List Tile');

    // Verify the Icon and Text widgets' properties
    expect(iconFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);

    // Verify the Text widget's style
    final textWidget = tester.widget<Text>(textFinder);
    expect(textWidget.style!.fontSize, 12);
    expect(textWidget.style!.color, Colors.grey);
    expect(textWidget.style!.fontWeight, FontWeight.bold);
  });
}
