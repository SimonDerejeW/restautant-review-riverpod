// Mocks generated by Mockito 5.4.4 from annotations
// in restaurant_review/test/unit/admin/admin_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:restaurant_review/infrastructure/admin/admin_service.dart'
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

/// A class which mocks [AdminService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdminService extends _i1.Mock implements _i3.AdminService {
  MockAdminService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get userUrl => (super.noSuchMethod(
        Invocation.getter(#userUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#userUrl),
        ),
      ) as String);

  @override
  String get banUrl => (super.noSuchMethod(
        Invocation.getter(#banUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#banUrl),
        ),
      ) as String);

  @override
  _i5.Future<_i2.Response> banUser(String? username) => (super.noSuchMethod(
        Invocation.method(
          #banUser,
          [username],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #banUser,
            [username],
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> unbanUser(String? username) => (super.noSuchMethod(
        Invocation.method(
          #unbanUser,
          [username],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #unbanUser,
            [username],
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> getAllCustomers() => (super.noSuchMethod(
        Invocation.method(
          #getAllCustomers,
          [],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getAllCustomers,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> getAllOwners() => (super.noSuchMethod(
        Invocation.method(
          #getAllOwners,
          [],
        ),
        returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #getAllOwners,
            [],
          ),
        )),
      ) as _i5.Future<_i2.Response>);
}
