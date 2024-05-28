// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:restaurant_review/application/retaurant/restaurant_event.dart';
import 'package:restaurant_review/application/retaurant/restaurant_provider.dart';
import 'package:restaurant_review/application/retaurant/restaurant_state.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/presentation/widgets/dialog_box.dart';

import '../widgets/comments.dart';
import '../widgets/list_tile.dart';
import '../widgets/user_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_review/presentation/widgets/dialog_box.dart';
import '../widgets/comments.dart';
import '../widgets/list_tile.dart';
import '../widgets/user_tile.dart';

class RestaurantPage extends ConsumerStatefulWidget {
  final String restaurantId;
  const RestaurantPage({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends ConsumerState<RestaurantPage> {
  @override
  void initState() {
    super.initState();
    // Trigger the fetchRestaurantById event when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(restaurantNotifierProvider.notifier)
          .mapEventToState(FetchRestaurantByIdRequested(widget.restaurantId));
    });
  }

  void cancelTask() {
    Navigator.of(context).pop();
  }

  void createNewComment() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onCancel: cancelTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantNotifierProvider);

    ref.listen<RestaurantState>(restaurantNotifierProvider, (previous, next) {
      if (next is RestaurantError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    return Scaffold(
      body: state is RestaurantLoading
          ? Center(child: CircularProgressIndicator())
          : state is RestaurantDetailLoaded
              ? _buildRestaurantDetail(state.restaurant)
              : state is RestaurantError
                  ? Center(child: Text(state.message))
                  : Container(), // Placeholder for other states
      floatingActionButton: FloatingActionButton(
        onPressed: createNewComment,
        shape: CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
            Icons.add,
            size: 40,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 255, 189, 74),
                Color.fromARGB(255, 248, 157, 72),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantDetail(RestaurantDTO restaurant) {
    return SizedBox(
      height: 1000,
      child: SingleChildScrollView(
          child: Column(children: [
        Container(
          width: double.infinity,
          height: 200,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/pizza.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Text('${restaurant.name}',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black, fontSize: 20)),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '(${restaurant.comments.length})',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        list_tile(
                          title: '${restaurant.location}',
                          leading: Icon(Icons.location_on,
                              size: 17, color: Colors.orange),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        list_tile(
                          title: 'Mon - Fri | ${restaurant.openingTime} - ${restaurant.closingTime}',
                          leading: Icon(
                            Icons.access_time_outlined,
                            size: 17,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'Open',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  '${restaurant.description}'),
              Container(
                  margin: EdgeInsets.only(bottom: 20, top: 5),
                  child: Text(
                    '+ Read More',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  )),
              Row(children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Reviews',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.black, fontSize: 18),
                )
              ]),
              Comment(
                  user_info: UserTile(
                      name: 'Darrow Lykos', date: 'Nov 1, 2023', image: ''),
                  comment:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lobortis lorem a ultrices rhoncus. Nam efficitur sapien et tincidunt laoreet. Nulla non ante lacus. Morbi lorem mauris, posuere et risus ac, accumsan fringilla orci. Curabitur id sem in risus accumsan elementum.'),
              Comment(
                  user_info: UserTile(
                      name: 'Darrow Lykos', date: 'Nov 1, 2023', image: ''),
                  comment:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque lobortis lorem a ultrices rhoncus. Nam efficitur sapien et tincidunt laoreet. Nulla non ante lacus. Morbi lorem mauris, posuere et risus ac, accumsan fringilla orci. Curabitur id sem in risus accumsan elementum.'),
            ],
          ),
        )
      ])),
    );
  }
}
