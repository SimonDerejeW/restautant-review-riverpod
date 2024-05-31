// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:restaurant_review/presentation/widgets/dialog_box.dart';

// void main() {
//   testWidgets('DialogBox widget test', (WidgetTester tester) async {
//     // Build the DialogBox widget
//     bool cancelCalled = false;
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Material(
//           child: DialogBox(
//             onCancel: () {
//               cancelCalled = true;
//             }, // Dummy onCancel function
//             onSubmit: (String newOpinion) {}, // Dummy onSubmit function
//             initialOpinion: '', // Initial opinion
//           ),
//         ),
//       ),
//     );

//     // Test text field functionality
//     await tester.enterText(find.byType(TextField), 'This is a review');
//     expect(find.text('This is a review'), findsOneWidget);

//     // Test button functionality
//     await tester.tap(find.text('Save'));
//     await tester.pumpAndSettle(); // Wait for animations to complete
//     // Ensure that onSubmit is called upon pressing the "Save" button
//     // Replace the next line with your validation logic
//     // expect(submitCalled, true);

//     await tester.tap(find.text('Cancel'));
//     await tester.pumpAndSettle(); // Wait for animations to complete
//     // Ensure that onCancel is called upon pressing the "Cancel" button
//     // Replace the next line with your validation logic
//     expect(cancelCalled, true);

//     // // Verify that the dialog is closed after button tap
//     // expect(find.byType(DialogBox), findsNothing);
//   });
// }
