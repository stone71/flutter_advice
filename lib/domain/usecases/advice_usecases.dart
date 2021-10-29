import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUsecases {
  Future sleep1() {
    return Future.delayed(const Duration(seconds: 2), () => "2");
  }

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    // call function from repository to get advice

    // business logic implementieren, z.b. rechnung...
    await sleep1();

    //return Left(ServerFailure());
    return Right(AdviceEntity(advice: "Test Advice", id: 1));
  }
}
