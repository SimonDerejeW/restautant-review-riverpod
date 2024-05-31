import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/search_widget.dart';

void main() {
  testWidgets('SearchWidget displays correctly', (WidgetTester tester) async {
    // Build the SearchWidget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SearchWidget(),
        ),
      ),
    );

    // Find elements in the SearchWidget
    final hintTextFinder = find.text('Search Restaurants...');
    final iconFinder = find.byIcon(Icons.search);

    // Verify the elements are found
    expect(hintTextFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('SearchWidget has a TextField widget',
      (WidgetTester tester) async {
    // Build the SearchWidget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SearchWidget(),
        ),
      ),
    );

    // Find TextField widget
    final textFieldFinder = find.byType(TextField);

    // Verify TextField is found
    expect(textFieldFinder, findsOneWidget);
  });

  testWidgets('SearchWidget has correct decoration',
      (WidgetTester tester) async {
    // Build the SearchWidget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SearchWidget(),
        ),
      ),
    );

    // Find TextField widget
    final textField = tester.widget<TextField>(find.byType(TextField));

    // Verify decoration properties
    expect(textField.decoration!.hintText, "Search Restaurants...");
    expect(
        textField.decoration!.border,
        OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none));

    expect(textField.decoration!.filled, true);
    expect(textField.decoration!.contentPadding, const EdgeInsets.all(20));
  });
}
