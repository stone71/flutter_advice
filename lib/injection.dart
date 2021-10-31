import 'package:flutter_advice/application/advice/advice_bloc.dart';
import 'package:flutter_advice/domain/repositories/advice_repository.dart';
import 'package:flutter_advice/domain/usecases/advice_usecases.dart';
import 'package:flutter_advice/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:flutter_advice/infrastructure/repositories/advice_repository_impl.dart';
import 'package:get_it/get_it.dart';

import 'package:dio/dio.dart';

final sl = GetIt.instance; // sl == service Locator (GetIt.I)

Future<void> init() async {
  //! application layer
  sl.registerFactory(() => AdviceBloc(sl()));

  //! Usecases
  sl.registerLazySingleton(() => AdviceUsecases(adviceRepository: sl()));

  //! repos
  sl.registerLazySingleton<AdviceRepository>(
      () => AdviceRepositoryImpl(adviceRemoteDatasource: sl()));

  //! datasources
  sl.registerLazySingleton<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImpl(client: sl()));

  //! extern
  sl.registerLazySingleton(() => Dio());
}
