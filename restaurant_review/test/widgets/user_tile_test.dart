import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/user_tile.dart'; // Update package name and file path as necessary

void main() {
  testWidgets('UserTile displays user information and actions', (WidgetTester tester) async {
    // Define test data
    const String testName = 'John Doe';
    const String testDate = '2024-05-30';
    const String testImage = 'assets/images/default_profile.jpg';

    // Define mock functions for edit and delete actions
    bool editPressed = false;
    bool deletePressed = false;
    void handleEdit() {
      editPressed = true;
    }

    void handleDelete() {
      deletePressed = true;
    }

    // Build the UserTile widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: UserTile(
            name: testName,
            date: testDate,
            image: testImage,
            onEdit: handleEdit,
            onDelete: handleDelete,
          ),
        ),
      ),
    );

    // Find elements in the UserTile
    final nameFinder = find.text(testName);
    final dateFinder = find.text('Review Date · $testDate');
    final editButtonFinder = find.byIcon(Icons.edit);
    final deleteButtonFinder = find.byIcon(Icons.delete);

    // Verify the elements are found
    expect(nameFinder, findsOneWidget);
    expect(dateFinder, findsOneWidget);
    expect(editButtonFinder, findsOneWidget);
    expect(deleteButtonFinder, findsOneWidget);

    // Simulate tap on edit button
    await tester.tap(editButtonFinder);
    await tester.pump();

    // Verify edit callback is triggered
    expect(editPressed, true);

    // Simulate tap on delete button
    await tester.tap(deleteButtonFinder);
    await tester.pump();

    // Verify delete callback is triggered
    expect(deletePressed, true);
  });
}
