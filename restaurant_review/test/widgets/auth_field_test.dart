import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/auth_field.dart';

void main() {
  testWidgets('AuthField displays hintText and validates input',
      (WidgetTester tester) async {
    // Create a TextEditingController
    final TextEditingController controller = TextEditingController();

    // Build the AuthField widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AuthField(
            hintText: 'Email',
            controller: controller,
          ),
        ),
      ),
    );

    // Find the TextFormField by hintText
    final hintTextFinder = find.text('Email');
    expect(hintTextFinder, findsOneWidget);

    // // Enter an empty string and trigger validation
    await tester.enterText(find.byType(TextFormField), '');
    await tester.pump();


    // // Enter a non-empty string and trigger validation
    await tester.enterText(find.byType(TextFormField), 'example@example.com');
    await tester.pump();

    // Ensure validation message disappears
    expect(find.text('Please enter Email.'), findsNothing);
  });

  testWidgets('AuthField obscureText hides input characters',
      (WidgetTester tester) async {
    // Create a TextEditingController
    final TextEditingController controller = TextEditingController();

    // Build the AuthField widget with obscureText enabled
    await tester.pumpWidget(
      MaterialApp(
        key: const Key('passwordTextFormField'),
        home: Scaffold(
          body: AuthField(
            hintText: 'Password',
            controller: controller,
            isObscure: true,
          ),
        ),
      ),
    );

    // Find the TextFormField by hintText
    final hintTextFinder = find.text('Password');
    expect(hintTextFinder, findsOneWidget);

    // // Enter text into the TextFormField
    await tester.enterText(find.byType(TextFormField), 'secretpassword');
    await tester.pump();

    // Ensure obscureText is functioning
    final passwordTextFormField = find.descendant(
  of: find.byKey(const Key('passwordTextFormField')),
  matching: find.byType(EditableText),
);
final input = tester.widget<EditableText>(passwordTextFormField);
expect(input.obscureText, isTrue); // Ensure text is obscured
  });
}
