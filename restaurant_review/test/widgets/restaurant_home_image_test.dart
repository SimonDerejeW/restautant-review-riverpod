import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_review/presentation/widgets/restaurant_home_image.dart'; // Update file path as necessary

void main() {
  testWidgets('RestaurantHomeImage widget displays image correctly',
      (WidgetTester tester) async {
    // Define test data
    const String testImagePath = 'assets/burger.jpg';

    // Build the RestaurantHomeImage widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RestaurantHomeImage(imagePath: testImagePath),
        ),
      ),
    );

    // Find the Image widget
    final imageFinder = find.byType(Image);

    // Verify the Image widget's properties
    expect(imageFinder, findsOneWidget);
    final imageWidget = tester.widget<Image>(imageFinder);
    expect(imageWidget.image, const AssetImage(testImagePath));
    expect(imageWidget.fit, BoxFit.cover);
    expect(imageWidget.height, 160);
    expect(imageWidget.width, 160);
  });
}
