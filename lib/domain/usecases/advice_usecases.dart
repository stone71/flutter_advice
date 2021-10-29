import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_advice/domain/repositories/advice_repository.dart';

class AdviceUsecases {
  final AdviceRepository adviceRepository;
  AdviceUsecases({required this.adviceRepository});

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    // call function from repository to get advice
    return adviceRepository.getAdviceFromApi();

    // groessere Apps mit mehr Logik sollten hier auch
    // business logic implementieren, z.b. rechnung...
  }
}
