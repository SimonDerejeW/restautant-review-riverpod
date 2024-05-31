// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:restaurant_review/application/retaurant/restaurant_event.dart';
// import 'package:restaurant_review/application/retaurant/restaurant_notifier.dart';
// import 'package:restaurant_review/application/retaurant/restaurant_state.dart';
// import 'package:restaurant_review/domain/restaurant/restaurant_repository_interface.dart';
// import 'package:dartz/dartz.dart';

// // Import the generated mocks
// import 'package:mockito/annotations.dart';
// import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';

// import 'restaurant_repository_test.mocks.dart';

// @GenerateMocks([RestaurantRepositoryInterface])
// void main() {
//   late RestaurantNotifier notifier;
//   late MockRestaurantRepository mockRepository;
//   late MockRestaurantService mockService;

//   setUp(() {
//     mockRepository = MockRestaurantRepository();
//     mockService = MockRestaurantService();
//     notifier = RestaurantNotifier(mockRepository);
//   });

//   test('should fetch restaurants and update state accordingly', () async {
//     // Arrange
//     final mockRestaurants = [
//       RestaurantDTO(
//         id: '1',
//         name: 'Restaurant 1',
//         description: 'Description 1',
//         location: 'Location 1',
//         contact: 'Contact 1',
//         openingTime: '08:00 AM',
//         closingTime: '10:00 PM',
//         isBanned: false,
//         comments: [],
//       ),
//       RestaurantDTO(
//         id: '2',
//         name: 'Restaurant 2',
//         description: 'Description 2',
//         location: 'Location 2',
//         contact: 'Contact 2',
//         openingTime: '09:00 AM',
//         closingTime: '11:00 PM',
//         isBanned: false,
//         comments: [],
//       ),
//     ];
//     when(mockRepository.fetchAllRestaurants())
//         .thenAnswer((_) async => Right(mockRestaurants));

//     // Act
//     await notifier.mapEventToState(FetchRestaurantsRequested());

//     // Assert
//     expect(notifier.state, equals(RestaurantLoaded(mockRestaurants)));
//     verify(mockRepository.fetchAllRestaurants());
//     verifyNoMoreInteractions(mockRepository);
//   });
// }
