# flutter_advice

A new Flutter project.

## v0.1 - Getting Started
- execution of 'flutter create flutter_advice'
- remove unnecessary code (empty project)
- update themedata('theme.dart') and main

## v0.2 - add Presentation Layer
- update main.dart
- add advice_page.dart
- add advice_field.dart
- add custom_button.dart
- add error_message.dart

## v0.3 - add Application Layer
- add packages bloc and flutter_bloc
- update main.dart
- update advice_page.dart
- update custom_button.dart
- add advice_bloc.dart
- add advice_event.dart
- add advice_state.dart

## v0.4 - add Domain Layer
- add package dartz
- update error_message.dart
- update advice_page.dart
- update advice_state.dart
- update advice_bloc.dart
- add advice_usecases.dart
- add advice_repository.dart
- add failures.dart
- add advice_entities.dart

## v0.5 - add Infrastructure Layer
- add packages equatable and http
- add advice_remote_datasource.dart
- add exceptios.dart
- add advice_model.dart
- add advice_repository_impl.dart
- update advice_usecases.dart
- update advice_repository.dart
- update advice_bloc.dart
- update main.dart

## v0.6 - add DI clean architecture
- add package get_it
- add injection.dart
- update main.dart
- update advice_repository_impl.dart
- update advice_remote_datasource.dart
- update advice_usecases.dart
- update advice_bloc.dart

## v0.7 - Unit Testing
- add dev packages mockito and build_runner
- execute 'dart run build_runner build --delete_conflicting_outputs' to generate mocks
- add fixtures/advice.json
- add fixtures/advice_http_respond.json
- add fixtures/fixture_reader.dart
- add application/advice/advice_bloc_test.dart
- add application/advice/advice_bloc_test.mocks.dart
- add domain/usecases/advice_usecases_test.dart
- add domain/usecases/advice_usecases_test.mocks.dart
- add infrastructure/datasource/advice_remote_datasource_test.dart
- add infrastructure/datasource/advice_remote_datasource_test.mocks.dart
- add infrastructure/models/advice_model_test.dart
- add infrastructure/repository/advice_repository_test.dart
- add infrastructure/repository/advice_repository_test.mocks.dart

## v0.8 - bugfixing(cors) and other http client
- fix to cors in flutter web using (https://thingproxy.freeboard.io/fetch/)

## v0.9 - refacturing all layer to advice
- change package dio tp http
- all layer add advice folder
- check all tests, there is only a fix to do with the url-test

## v0.10 - refacturing warnings
- refacture warnings (only warnings in automated generated mock-files)