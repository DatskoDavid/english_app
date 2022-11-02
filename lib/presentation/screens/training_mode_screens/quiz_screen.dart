import 'package:flutter/material.dart';

import '../../../data/get_word_service.dart';
import '../../widgets/next_screen_btn.dart';
import 'input_word_screen.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = 'quiz';

  final WordApi word;

  QuizScreen({super.key, required this.word});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Screen'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 100, 190, 103),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.word.results[0].definition,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _answer(widget.word.word, true),
            const SizedBox(height: 10),
            _answer('Random word from vocabulary (use Hive)', false),
            const SizedBox(height: 10),
            _answer('If not enough words in vocabulary use prerecorded list',
                false),
            const SizedBox(height: 10),
            _answer('Random word', false),
            const SizedBox(height: 20),
            NextScreenBtn(
              routeName: InputWordScreen.routeName,
              arguments: widget.word,
            ),
          ],
        ),
      ),
    );
  }

  Widget _answer(String answer, bool isCorrect) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color.fromARGB(255, 219, 220, 221),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            // side: const BorderSide(color: Colors.indigo),
          ),
        ),
      ),
      onPressed: () {},
      child: Center(
        child: Text(
          answer,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
