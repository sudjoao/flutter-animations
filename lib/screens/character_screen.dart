import 'package:flutter/material.dart';
import 'package:marvel_animations/models/character.dart';

class CharacterScreenArguments {
  final Character character;

  CharacterScreenArguments(this.character);
}

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as CharacterScreenArguments;
    final Character character = args.character;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Info'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              character.name,
              style: theme.textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 24,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: character.name,
                child: Image.network(
                  character.image,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              character.description,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      )),
    );
  }
}
