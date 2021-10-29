// Mocks generated by Mockito 5.0.16 from annotations
// in flutter_advice/test/infrastructure/repository/advice_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_advice/domain/entities/advice_entity.dart' as _i2;
import 'package:flutter_advice/infrastructure/datasources/advice_remote_datasource.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAdviceEntity_0 extends _i1.Fake implements _i2.AdviceEntity {}

/// A class which mocks [AdviceRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockAdviceRemoteDatasource extends _i1.Mock
    implements _i3.AdviceRemoteDatasource {
  MockAdviceRemoteDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AdviceEntity> getRandomAdviceFromApi() => (super.noSuchMethod(
          Invocation.method(#getRandomAdviceFromApi, []),
          returnValue: Future<_i2.AdviceEntity>.value(_FakeAdviceEntity_0()))
      as _i4.Future<_i2.AdviceEntity>);
  @override
  String toString() => super.toString();
}
