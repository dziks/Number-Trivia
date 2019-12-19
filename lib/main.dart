import 'package:flutter/material.dart';
import 'package:number_trivial/injection_container.dart' as di;

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dziks Number Trivia ',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      home: NumberTriviaPage(),
    );
  }
}