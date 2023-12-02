import 'package:flutter/material.dart';
import 'package:marvel_animations/models/character.dart';
import 'package:marvel_animations/services/marvel.dart';
import 'package:marvel_animations/widgets/card.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> characters = [];

  @override
  void initState() {
    super.initState();
    MarvelService().getCharacters().then((List<Character> characters) {
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
                      return CardWidget(character: characters[index]);
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
