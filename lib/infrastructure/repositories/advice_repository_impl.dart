import 'package:flutter_advice/domain/failures/failures.dart';
import 'package:flutter_advice/domain/entities/advice_entity.dart';
import 'package:flutter_advice/domain/repositories/advice_repository.dart';
import 'package:flutter_advice/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:flutter_advice/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdvicerRemoteDatasource advicerRemoteDatasource =
      AdvicerRemoteDatasourceImpl();
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {
      final remoteAdvice =
          await advicerRemoteDatasource.getRandomAdviceFromApi();
      return Right(remoteAdvice);
    } catch (e) {
      if (e.runtimeType is SeverException) {
        return Left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
