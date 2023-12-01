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

  void onPressed() {
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CardWidget(title: 'Card Widget'),
              CardWidget(title: 'Card Widget 2'),
              TextButton(onPressed: onPressed, child: Text('Press me')),
              Expanded(
                child: ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(characters[index].name),
                    );
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
