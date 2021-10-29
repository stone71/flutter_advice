import 'package:flutter_advice/domain/entities/advice_entity.dart';

abstract class AdviceRepository {
  Future<AdviceEntity> getAdviceFromApi();
}
