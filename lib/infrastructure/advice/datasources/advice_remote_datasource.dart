import 'package:flutter_advice/domain/advice/entities/advice_entity.dart';
import 'package:flutter_advice/infrastructure/advice/exceptions/exceptions.dart';
import 'package:flutter_advice/infrastructure/advice/models/advice_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AdviceRemoteDatasource {
  /// requests a randmom advice from free api
  /// throws a server-Exception if respond code is not 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  final http.Client client;
  AdviceRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    var url = "https://api.adviceslip.com/advice";
    if (kIsWeb) {
      //url = "https://cors-anywhere.herokuapp.com/https://api.adviceslip.com/advice";
      // running on the web!
      url =
          "https://thingproxy.freeboard.io/fetch/https://api.adviceslip.com/advice";
    }

    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);

      return AdviceModel.fromJson(responseBody["slip"]);
    }
  }
}
