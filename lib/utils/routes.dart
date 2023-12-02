import 'package:flutter/material.dart';
import 'package:marvel_animations/screens/character_list_screen.dart';
import 'package:marvel_animations/screens/character_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (BuildContext context) =>
      const CharacterListScreen(title: 'Marvel Characters'),
  '/character': (BuildContext context) => const CharacterScreen(),
};
