import 'dart:convert';

import 'package:flutter_advice/domain/advice/entities/advice_entity.dart';
import 'package:flutter_advice/infrastructure/advice/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final t_Advice_Model = AdviceModel(advice: "Test", id: 1);

  test("model should be subclass of advice-entity", () {
    //assert
    expect(t_Advice_Model, isA<AdviceEntity>());
  });

  group("fromJson Factory", () {
    test("should return a valid model if the json advice is correct", () {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("advice.json"));

      //act
      final result = AdviceModel.fromJson(jsonMap);

      //assert
      expect(result, t_Advice_Model);
    });
  });
}
