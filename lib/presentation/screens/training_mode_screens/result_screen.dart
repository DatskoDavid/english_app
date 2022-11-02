import 'package:flutter/material.dart';

import '../../../data/get_word_service.dart';
import '../home_screen.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = 'result';

  final WordApi word;

  const ResultScreen({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your progress in learn of word',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              word.word,
              style: const TextStyle(
                  // color: Colors.indigo,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: Stack(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: CircularProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey[400],
                      strokeWidth: 8,
                    ),
                  ),
                  const Center(
                    child: Text(
                      '50%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
      ),
    );
  }
}
