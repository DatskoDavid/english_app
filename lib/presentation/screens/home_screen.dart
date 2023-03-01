import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

import 'true_training_mode/training_controller.dart';
import 'vocabulary_screen.dart';
import 'word_info_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English App'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: _wordOfDay(_randomWord(), context),
          ),
          const SizedBox(height: 10),
          _getButton('Vocabulary', context, VocabularyScreen.routeName),
          const SizedBox(height: 3),
          _getButton('Training words', context, TrainingController.routeName),
          const SizedBox(height: 10),
          _settingsButton(context, ''),
          /* const SizedBox(height: 50),
          niceBtn('Training words', context, WordInfoScreen.routeName), */
        ],
      ),
    );
  }

  Widget _getButton(name, context, routeName) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        tileColor: const Color.fromARGB(255, 124, 192, 226),
        hoverColor: const Color.fromARGB(255, 43, 158, 216),
        dense: true,
        title: Center(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }

  Widget _settingsButton(context, routeName) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        tileColor: const Color.fromARGB(255, 156, 171, 179),
        hoverColor: const Color.fromARGB(255, 105, 117, 124),
        dense: true,
        title: const Center(
          child: Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }

  Widget niceBtn(String name, BuildContext context, String routeName) {
    return NiceButtons(
      stretch: true,
      startColor: Colors.indigo,
      gradientOrientation: GradientOrientation.Horizontal,
      onTap: () => Navigator.pushNamed(context, routeName),
      child: const Text(
        'Full Width',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _wordOfDay(String randomWord, BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromARGB(255, 247, 242, 230),
      child: InkWell(
        splashColor: const Color.fromARGB(255, 221, 219, 219),
        onTap: () => Navigator.pushNamed(context, WordInfoScreen.routeName,
            arguments: randomWord),
        child: Material(
          color: Colors.transparent,
          child: Container(
              padding: const EdgeInsets.all(8),
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber, width: 2),
              ),
              child: Stack(
                children: [
                  const Icon(
                    Icons.lightbulb_sharp,
                    color: Colors.amber,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      randomWord,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )
              /* child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.lightbulb_sharp, color: Colors.amber),
                const Spacer(flex: 2),
                Text(
                  randomWord,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const Spacer(flex: 3),
              ],
            ), */
              ),
        ),
      ),
    );
  }

  //TODO: remake in order to get words via bloc
  /* String _randomWord() {
    final vocabularySize = Hive.box<Word>(BoxNames.words).length;
    final random = Random();

    final randomIndex = random.nextInt(vocabularySize);

    return Hive.box<Word>(BoxNames.words).getAt(randomIndex)!.word!;
  } */

  String _randomWord() {
    return 'permit';
  }
}
