import 'package:flutter/material.dart';
import 'package:marvel_animations/models/character.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.character}) : super(key: key);

  final Character character;

  String description() {
    return character.description.isNotEmpty
        ? character.description
        : "No description";
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: character.name,
                child: Image.network(
                  character.image,
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220,
                  child: Text(
                    character.name,
                    style: theme.textTheme.headlineMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 220,
                  child: Text(
                    description(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
