// Updated RestaurantPage

import 'package:flutter/material.dart';
import 'package:restaurant_review/application/comment/comment_notifier.dart';
import 'package:restaurant_review/application/comment/comment_event.dart';
import 'package:restaurant_review/application/comment/comment_state.dart';
import 'package:restaurant_review/application/retaurant/restaurant_event.dart';
import 'package:restaurant_review/application/retaurant/restaurant_provider.dart';
import 'package:restaurant_review/application/retaurant/restaurant_state.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/presentation/widgets/dialog_box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/comments.dart';
import '../widgets/list_tile.dart';
import '../widgets/user_tile.dart';

class RestaurantPage extends ConsumerStatefulWidget {
  final String restaurantId;
  const RestaurantPage({super.key, required this.restaurantId});

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
    print(widget.restaurantId);
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onCancel: cancelTask,
          onSubmit: (opinion) {
            ref.read(commentNotifierProvider.notifier).mapEventToState(
                  CreateComment(widget.restaurantId, opinion),
                );
          },
          initialOpinion: '',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurantState = ref.watch(restaurantNotifierProvider);
    final commentState = ref.watch(commentNotifierProvider);

    ref.listen<RestaurantState>(restaurantNotifierProvider, (previous, next) {
      if (next is RestaurantError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    ref.listen<CommentState>(commentNotifierProvider, (previous, next) {
      if (next is CommentError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      } else if (next is CommentLoaded) {
        // Refresh the restaurant details to reflect new comments
        ref
            .read(restaurantNotifierProvider.notifier)
            .mapEventToState(FetchRestaurantByIdRequested(widget.restaurantId));
      }
    });

    return Scaffold(
      body:
          restaurantState is RestaurantLoading || commentState is CommentLoading
              ? const Center(child: CircularProgressIndicator())
              : restaurantState is RestaurantDetailLoaded
                  ? _buildRestaurantDetail(restaurantState.restaurant)
                  : restaurantState is RestaurantError
                      ? Center(child: Text(restaurantState.message))
                      : Container(), // Placeholder for other states
      floatingActionButton: FloatingActionButton(
        onPressed: createNewComment,
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 255, 189, 74),
                Color.fromARGB(255, 248, 157, 72),
              ],
            ),
          ),
          child: const Icon(
            Icons.add,
            size: 40,
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
        SizedBox(
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
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(restaurant.name,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: Colors.black, fontSize: 20)),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '(${restaurant.comments.length})',
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        list_tile(
                          title: restaurant.location,
                          leading: const Icon(Icons.location_on,
                              size: 17, color: Colors.orange),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        list_tile(
                          title:
                              'Mon - Fri | ${restaurant.openingTime} - ${restaurant.closingTime}',
                          leading: const Icon(
                            Icons.access_time_outlined,
                            size: 17,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      'Open',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(restaurant.description),
              Container(
                  margin: const EdgeInsets.only(bottom: 20, top: 5),
                  child: const Text(
                    '+ Read More',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  )),
              Row(children: [
                const SizedBox(
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
              const SizedBox(
                height: 10,
              ),
              ...restaurant.comments.map((comment) {
                return Comment(
                  user_info: UserTile(
                    name: comment.username,
                    date: 'Nov 1, 2023',
                    image: 'assets/images/default_profile.jpg',
                    onEdit: () => _editComment(comment.id, comment.opinion),
                    onDelete: () => _deleteComment(comment.id),
                  ),
                  comment: comment.opinion,
                );
              })
            ],
          ),
        )
      ])),
    );
  }

  void _editComment(String commentId, String currentOpinion) {
    // print(widget.restaurantId);
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          initialOpinion: currentOpinion,
          onCancel: cancelTask,
          onSubmit: (newOpinion) {
            ref.read(commentNotifierProvider.notifier).mapEventToState(
                  UpdateComment(commentId, newOpinion, widget.restaurantId),
                );
          },
        );
      },
    );
  }

  void _deleteComment(String commentId) {
    // print(widget.restaurantId);
    ref.read(commentNotifierProvider.notifier).mapEventToState(
          DeleteComment(commentId, widget.restaurantId),
        );
  }
}
