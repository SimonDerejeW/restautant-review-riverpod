import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/comments.dart';

void main() {
  testWidgets('Comment widget displays user_info and comment',
      (WidgetTester tester) async {
    // Define the user_info widget and comment text
    const userInfo = Text('User Info');
    const commentText = 'This is a comment';

    // Build the Comment widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Comment(
            user_info: userInfo,
            comment: commentText,
          ),
        ),
      ),
    );

    // Verify that the user_info widget is displayed
    expect(find.text('User Info'), findsOneWidget);

    // Verify that the comment text is displayed
    expect(find.text(commentText), findsOneWidget);
  });

  testWidgets('Comment widget displays user_info with a custom widget',
      (WidgetTester tester) async {
    // Define a custom user_info widget and comment text
    const userInfo = Row(
      children: [
        Icon(Icons.person),
        SizedBox(width: 8),
        Text('John Doe'),
      ],
    );
    const commentText = 'This is a comment';

    // Build the Comment widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Comment(
            user_info: userInfo,
            comment: commentText,
          ),
        ),
      ),
    );

    // Verify that the custom user_info widget is displayed
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);

    // Verify that the comment text is displayed
    expect(find.text(commentText), findsOneWidget);
  });
}
