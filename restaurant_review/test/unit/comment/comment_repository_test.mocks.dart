// Mocks generated by Mockito 5.4.4 from annotations
// in restaurant_review/test/unit/comment/comment_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:restaurant_review/infrastructure/comment/comment_service.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CommentService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCommentService extends _i1.Mock implements _i3.CommentService {
  MockCommentService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i5.Future<_i2.Response> createComment(
    String? restaurantId,
    String? opinion,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createComment,
          [
            restaurantId,
            opinion,
          ],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #createComment,
            [
              restaurantId,
              opinion,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> updateComment(
    String? commentId,
    String? newOpinion,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateComment,
          [
            commentId,
            newOpinion,
          ],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #updateComment,
            [
              commentId,
              newOpinion,
            ],
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> deleteComment(String? commentId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteComment,
          [commentId],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #deleteComment,
            [commentId],
          ),
        )),
      ) as _i5.Future<_i2.Response>);
}
