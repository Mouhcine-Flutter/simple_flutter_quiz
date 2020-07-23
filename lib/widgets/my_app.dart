import 'package:flutter/material.dart';
import 'package:quizz/widgets/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizz demo app',
      theme: ThemeData(appBarTheme: AppBarTheme(color: Color(0xFF151026))),
      home: MyHomePage(title: 'Quizz App'),
    );
  }
}
