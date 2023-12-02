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
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

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

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        setState(() {
          isLoading = true;
        });
        MarvelService().getCharacters(args: {
          'series': 2258,
          'offset': characters.length
        }).then((List<Character> characters) {
          setState(() {
            this.characters.addAll(characters);
            isLoading = false;
          });
        });
      }
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
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: characters.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => navigateToCharacterScreen(characters[index]),
                      child: CardWidget(character: characters[index]),
                    );
                  },
                ),
              ),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
