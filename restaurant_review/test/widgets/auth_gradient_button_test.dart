import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/auth_gradient_button.dart';

void main() {
  testWidgets('AuthGradientButton displays correct text and handles tap',
      (WidgetTester tester) async {
    // Variables to track the button press
    bool buttonPressed = false;

    // Build the AuthGradientButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthGradientButton(
            buttonText: 'Login',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    // Verify the button text
    expect(find.text('Login'), findsOneWidget);

    // Verify the button's onPressed callback
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Ensure that the button press was registered
    expect(buttonPressed, true);
  });
}
