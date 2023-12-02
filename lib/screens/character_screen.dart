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

class _CharacterScreenState extends State<CharacterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // 2. Create Animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    // 3. Add listener to AnimationController
    _controller.addListener(() {
      setState(() {});
    });

    // 4. Start AnimationController
    _controller.forward();
  }

  @override
  void dispose() {
    // 5. Dispose AnimationController
    _controller.dispose();
    super.dispose();
  }

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
        actions: [
          _animation.isCompleted
              ? IconButton(
                  onPressed: restartAnimation, icon: const Icon(Icons.replay))
              : Container()
        ],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: theme.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                Hero(
                  tag: character.name,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      character.image,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.height * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.55,
              left: (MediaQuery.of(context).size.width * _animation.value) -
                  MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width - 32,
              child: Text(
                character.description,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
