import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_review/infrastructure/restaurant/restaurant_repository.dart';
import 'package:restaurant_review/infrastructure/restaurant/restaurant_dto.dart';
import 'package:restaurant_review/domain/restaurant/restaurant_failure.dart';
import 'package:restaurant_review/infrastructure/restaurant/restuarant_service.dart';

import 'restaurant_repository_test.mocks.dart';

@GenerateMocks([RestaurantService])
void main() {
  late RestaurantRepository repository;
  late MockRestaurantService mockRestaurantService;

  setUp(() {
    mockRestaurantService = MockRestaurantService();
    repository = RestaurantRepository(mockRestaurantService);
  });

  group('fetchAllRestaurants', () {
    test('should return a list of RestaurantDTO when the call is successful',
        () async {
      // Arrange
      final List<Map<String, dynamic>> jsonList = [
        {
          "id": "1",
          "name": "Restaurant 1",
          "description": "Description 1",
          "location": "Location 1",
          "contact": "Contact 1",
          "openingTime": "09:00",
          "closingTime": "22:00",
          "isBanned": false,
          "comments": []
        },
        {
          "id": "2",
          "name": "Restaurant 2",
          "description": "Description 2",
          "location": "Location 2",
          "contact": "Contact 2",
          "openingTime": "10:00",
          "closingTime": "23:00",
          "isBanned": false,
          "comments": []
        },
      ];

      final responseJson = jsonEncode(jsonList);

      when(mockRestaurantService.fetchAllRestaurants())
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final result = await repository.fetchAllRestaurants();

      print(result);
      // Assert
      result.fold(
        (failure) => expect(failure, isA<RestaurantFailure>()),
        (restaurants) {
          expect(restaurants, isA<List<RestaurantDTO>>());
          expect(restaurants.length, 2);
          expect(restaurants[0].id, '1');
          expect(restaurants[1].id, '2');
        },
      );
    });

    // test('should return a RestaurantFailure when the call is unsuccessful',
    //     () async {
    //   // Arrange
    //   when(mockRestaurantService.fetchAllRestaurants())
    //       .thenAnswer((_) async => http.Response('Error occurred', 404));

    //   // Act
    //   final result = await repository.fetchAllRestaurants();

    //   // Assert
    //   result.fold(
    //     (failure) {
    //       expect(failure, isA<RestaurantFailure>());
    //       expect(failure.message, 'Error occurred');
    //     },
    //     (restaurants) =>
    //         fail('Expected a failure but got a list of restaurants'),
    //   );
    // });

//     group('fetchRestaurantById', () {
//       test('should return restaurant when the call is successful', () async {
//         // Arrange
//         final expectedRestaurant = RestaurantDTO(
//           id: '1',
//           name: 'Restaurant 1',
//           description: 'Description 1',
//           location: 'Location 1',
//           contact: 'Contact 1',
//           openingTime: '08:00 AM',
//           closingTime: '10:00 PM',
//           isBanned: false,
//           comments: [],
//         );
//         when(mockRestaurantService.fetchRestaurantById('1')).thenAnswer(
//             (_) async => http.Response(json.encode(expectedRestaurant), 200));

//         // Act
//         final result = await repository.fetchRestaurantById('1');

//         print(result);

//         // Assert
//         expect(result, isA<>());
//         verify(mockRestaurantService.fetchRestaurantById('1'));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });

//       test('should return a failure when the call is unsuccessful', () async {
//         // Arrange
//         when(mockRestaurantService.fetchRestaurantById('1'))
//             .thenAnswer((_) async => http.Response('Error occurred', 500));

//         // Act
//         final result = await repository.fetchRestaurantById('1');

//         // Assert
//         expect(result, equals(left(const RestaurantFailure('Error occurred'))));
//         verify(mockRestaurantService.fetchRestaurantById('1'));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });
//     });

//     group('createRestaurant', () {
//       test('should return created restaurant when the call is successful',
//           () async {
//         // Arrange
//         final createRestaurantDto = CreateRestaurantDTO(
//           name: 'New Restaurant',
//           description: 'Description',
//           location: 'Location',
//           contact: 'Contact',
//           openingTime: '08:00 AM',
//           closingTime: '10:00 PM',
//         );
//         final expectedRestaurant = CreateRestaurantDTO(
//           name: 'New Restaurant',
//           description: 'Description',
//           location: 'Location',
//           contact: 'Contact',
//           openingTime: '08:00 AM',
//           closingTime: '10:00 PM',
//         );
//         when(mockRestaurantService.createRestaurant(createRestaurantDto))
//             .thenAnswer((_) async =>
//                 http.Response(json.encode(expectedRestaurant), 201));

//         // Act
//         final result = await repository.createRestaurant(createRestaurantDto);

//         // Assert
//         expect(result, isA<Left<RestaurantFailure, CreateRestaurantDTO>>());
//         verify(mockRestaurantService.createRestaurant(createRestaurantDto));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });

//       test('should return a failure when the call is unsuccessful', () async {
//         // Arrange
//         final createRestaurantDto = CreateRestaurantDTO(
//           name: 'New Restaurant',
//           description: 'Description',
//           location: 'Location',
//           contact: 'Contact',
//           openingTime: '08:00 AM',
//           closingTime: '10:00 PM',
//         );
//         when(mockRestaurantService.createRestaurant(createRestaurantDto))
//             .thenAnswer((_) async => http.Response('Error occurred', 500));

//         when(mockRestaurantService.checkOwnerRestaurant())
//             .thenAnswer((_) async => http.Response('Restaurant exists', 200));
//         // Act
//         final result = await repository.createRestaurant(createRestaurantDto);
//         print(result);

//         // Assert
//         expect(
//             result,
//             left<RestaurantFailure, CreateRestaurantDTO>(
//                 const RestaurantFailure('MissingStubError:')));
//         verify(mockRestaurantService.createRestaurant(createRestaurantDto));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });
//     });

//     group('updateRestaurant', () {
//       test('should return updated restaurant when the call is successful',
//           () async {
//         // Arrange
//         final updateRestaurantDto = UpdateRestaurantDTO(
//           name: 'Updated Restaurant',
//           description: 'Updated Description',
//           location: 'Updated Location',
//           contact: 'Updated Contact',
//           openingTime: '09:00 AM',
//           closingTime: '11:00 PM',
//         );
//         final expectedRestaurant = UpdateRestaurantDTO(
//           name: 'Updated Restaurant',
//           description: 'Updated Description',
//           location: 'Updated Location',
//           contact: 'Updated Contact',
//           openingTime: '09:00 AM',
//           closingTime: '11:00 PM',
//         );
//         when(mockRestaurantService.updateRestaurant('1', updateRestaurantDto))
//             .thenAnswer((_) async =>
//                 http.Response(json.encode(expectedRestaurant), 200));

//         // Act
//         final result = await repository.updateRestaurant(updateRestaurantDto);

//         // Assert
//         expect(result, equals(right(expectedRestaurant)));
//         verify(
//             mockRestaurantService.updateRestaurant('1', updateRestaurantDto));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });

//       test('should return a failure when the call is unsuccessful', () async {
//         // Arrange
//         final updateRestaurantDto = UpdateRestaurantDTO(
//           name: 'Updated Restaurant',
//           description: 'Updated Description',
//           location: 'Updated Location',
//           contact: 'Updated Contact',
//           openingTime: '09:00 AM',
//           closingTime: '11:00 PM',
//         );
//         when(mockRestaurantService.updateRestaurant('1', updateRestaurantDto))
//             .thenAnswer((_) async => http.Response('Error occurred', 500));

//         // Act
//         final result = await repository.updateRestaurant(updateRestaurantDto);

//         // Assert
//         expect(result, equals(left(const RestaurantFailure('Error occurred'))));
//         verify(
//             mockRestaurantService.updateRestaurant('1', updateRestaurantDto));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });
//     });

//     group('deleteRestaurant', () {
//       test('should return unit when the call is successful', () async {
//         // Arrange
//         when(mockRestaurantService.deleteRestaurant('1'))
//             .thenAnswer((_) async => http.Response('', 200));

//         // Act
//         final result = await repository.deleteRestaurant();

//         // Assert
//         expect(result, equals(right(unit)));
//         verify(mockRestaurantService.deleteRestaurant('1'));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });

//       test('should return a failure when the call is unsuccessful', () async {
//         // Arrange
//         when(mockRestaurantService.deleteRestaurant('1'))
//             .thenAnswer((_) async => http.Response('Error occurred', 500));

//         // Act
//         final result = await repository.deleteRestaurant();

//         // Assert
//         expect(result, equals(left(const RestaurantFailure('Error occurred'))));
//         verify(mockRestaurantService.deleteRestaurant('1'));
//         verifyNoMoreInteractions(mockRestaurantService);
//       });
//     });
  });
}
