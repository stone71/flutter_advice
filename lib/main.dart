import 'package:flutter/material.dart';
import 'package:flutter_advice/presentation/advice/advice_page.dart';
import 'package:flutter_advice/theme.dart';

void main() {
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
      home: const AdvicePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
