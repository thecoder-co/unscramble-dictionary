import 'package:dictionary/screens/dict.dart';
import 'package:dictionary/screens/home.dart';
import 'package:dictionary/screens/unscramble.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => Home(title: 'Home'),
        '/dictionary': (context) => Dict(title: 'Dictionary'),
        '/unscramble': (context) => Unscramble(title: 'Unscramble'),
      },
      initialRoute: '/',
    );
  }
}
