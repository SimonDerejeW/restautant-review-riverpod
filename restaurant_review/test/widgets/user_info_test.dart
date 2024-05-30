import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/user_info.dart';

void main() {
  testWidgets('UserInfo displays user information correctly',
      (WidgetTester tester) async {
    // Define test data
    const String testName = 'John Doe';
    const String testEmail = 'johndoe@example.com';
    const String testPhoneNumber = '+1234567890';

    // Build the UserInfo widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: UserInfo(
            name: testName,
            email: testEmail,
            phoneNumber: testPhoneNumber,
          ),
        ),
      ),
    );

    // Find elements in the UserInfo widget
    final nameFinder = find.text('Username');
    final emailFinder = find.text('Email Address');
    final phoneFinder = find.text('Phone Number');
    final testNameFinder = find.text(testName);
    final testEmailFinder = find.text(testEmail);
    final testPhoneFinder = find.text(testPhoneNumber);

    // Verify the elements are found
    expect(nameFinder, findsOneWidget);
    expect(emailFinder, findsOneWidget);
    expect(phoneFinder, findsOneWidget);
    expect(testNameFinder, findsOneWidget);
    expect(testEmailFinder, findsOneWidget);
    expect(testPhoneFinder, findsOneWidget);
  });
}
