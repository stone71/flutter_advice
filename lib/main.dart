import 'package:flutter/material.dart';
import 'package:flutter_advice/application/advice/advice_bloc.dart';
import 'package:flutter_advice/presentation/advice/advice_page.dart';
import 'package:flutter_advice/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart'; // di == dependency injection

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advice App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      // mehrere Provider MultiBlocProvider
      home: BlocProvider(
        create: (BuildContext context) => sl<AdviceBloc>(),
        child: const AdvicePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
