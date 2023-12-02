import 'package:flutter/material.dart';
import 'package:marvel_animations/models/character.dart';
import 'package:marvel_animations/screens/character_screen.dart';
import 'package:marvel_animations/services/marvel.dart';
import 'package:marvel_animations/widgets/card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late List<Character> characters = [];

  void navigateToCharacterScreen(Character character) {
    Navigator.pushNamed(
      context,
      '/character',
      arguments: CharacterScreenArguments(character),
    );
  }

  @override
  void initState() {
    super.initState();
    MarvelService().getCharacters(args: {'series': 2258}).then(
        (List<Character> characters) {
      setState(() {
        this.characters = characters;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () =>
                              navigateToCharacterScreen(characters[index]),
                          child: CardWidget(character: characters[index]));
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
