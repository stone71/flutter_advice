import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_advice/infrastructure/models/advice_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AdvicerRemoteDatasource {
  /// requests a randmom advice from free api
  /// throws a server-Exception if respond code is not 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdvicerRemoteDatasourceImpl implements AdvicerRemoteDatasource {
  final http.Client client = http.Client();

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
      },
    );

    if (response.statusCode != 200) {
      throw SeverException();
    } else {
      final responseBody = json.decode(response.body);

      return AdviceModel.fromJson(responseBody["slip"]);
    }
  }
}
