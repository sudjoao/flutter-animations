import 'package:flutter/material.dart';
import 'package:marvel_animations/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Animations',
      theme: ThemeData.dark(),
      routes: routes,
    );
  }
}
