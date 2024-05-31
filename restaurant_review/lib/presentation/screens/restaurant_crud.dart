// restaurant_crud.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/application/retaurant/restaurant_event.dart';
import 'package:restaurant_review/application/retaurant/restaurant_provider.dart';

import 'package:restaurant_review/presentation/screens/modal_form.dart';
import 'package:restaurant_review/presentation/screens/modal_update_form.dart';
import 'package:restaurant_review/presentation/widgets/Expansion_bar.dart';

class RestaurantCrud extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const Modal(),
                    );
                  },
                  child: const Text('Add Restaurant'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => UpdateModal(),
                    );
                  },
                  child: const Text('Edit Restaurant'),
                ),
              ],
            ),
            Container(
              child: ExpansionBar(
                title: 'Delete Restaurant',
                titleColor: Colors.red,
                children: Row(
                  children: [
                    const SizedBox(width: 15),
                    const Expanded(
                      child: Text(
                          'Are you sure you want to delete your restaurant?'),
                    ),
                  ],
                ),
                childOfButton1: 'Confirm',
                childOfButton2: 'Cancel',
                buttonBackgroundColor: Colors.red,
                onButton1Pressed: () {
                  ref.read(restaurantNotifierProvider.notifier).mapEventToState(
                        DeleteRestaurantRequested(),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Restaurant deleted')),
                  );
                },
                onButton2Pressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
