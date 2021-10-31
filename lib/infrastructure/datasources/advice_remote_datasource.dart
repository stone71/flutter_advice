import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_advice/infrastructure/models/advice_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:dio/dio.dart';
import 'dart:convert';

abstract class AdviceRemoteDatasource {
  /// requests a randmom advice from free api
  /// throws a server-Exception if respond code is not 200
  Future<AdviceEntity> getRandomAdviceFromApi();
}

class AdviceRemoteDatasourceImpl implements AdviceRemoteDatasource {
  final Dio client;
  AdviceRemoteDatasourceImpl({required this.client});

  @override
  Future<AdviceEntity> getRandomAdviceFromApi() async {
    var url = "https://api.adviceslip.com/advice";
    if (kIsWeb) {
      // running on the web!
      url =
          "https://thingproxy.freeboard.io/fetch/https://api.adviceslip.com/advice";
    }
    //Uri.parse("https://api.adviceslip.com/advice"),
    //Uri.parse("https://cors-anywhere.herokuapp.com/https://api.adviceslip.com/advice"),
    final response = await client.get(
      url,
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
      ),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.data);

      return AdviceModel.fromJson(responseBody["slip"]);
    }
  }
}
