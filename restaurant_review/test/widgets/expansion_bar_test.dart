// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:restaurant_review/presentation/widgets/Expansion_bar.dart';

// void main() {
//   testWidgets('ExpansionBar widget displays title and children correctly',
//       (WidgetTester tester) async {
//     // Define test data
//     const String testTitle = 'Expansion Bar';
//     const String testChildOfButton1 = 'Button 1';
//     const String testChildOfButton2 = 'Button 2';

//     // Build the ExpansionBar widget
//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: ExpansionBar(
//             title:
//                 testTitle, // You can replace Container() with any suitable widget for testing
//             childOfButton1: testChildOfButton1,
//             childOfButton2: testChildOfButton2,
//             buttonBackgroundColor: Colors.blue,
//             children: Container(),
//           ),
//         ),
//       ),
//     );
// // Find the ExpansionBar widget
//     final expansionBarFinder = find.byType(ExpansionBar);

// // Verify the ExpansionBar widget's properties
//     expect(expansionBarFinder, findsOneWidget);

// // Find the ExpansionTile within the ExpansionBar
//     final expansionTileFinder = find.descendant(
//       of: expansionBarFinder,
//       matching: find.byType(ExpansionTile),
//     );

// // Verify the ExpansionTile widget's properties
//     expect(expansionTileFinder, findsOneWidget);

// // Find the Buttons widgets within the ExpansionTile's children

// //     final buttonsFinder = find.descendant(
// //       of: expansionTileFinder,
// //       matching: find.byType(Row),
// //       skipOffstage: false, // Ensure that offstage widgets are considered
// //     );

// // // Verify the Buttons widgets' properties
// //     expect(buttonsFinder, findsNWidgets(1)); // Expecting two Buttons widgets
//   });
// }
