import 'package:flutter/material.dart';

import '../../../domain/models/training_info.dart';
import 'result_screen.dart';

class InputWordScreen extends StatefulWidget {
  static const routeName = '/input_word';

  final TrainingInfo trainingInfo;

  InputWordScreen({super.key, required this.trainingInfo});

  @override
  State<InputWordScreen> createState() => _InputWordScreenState();
}

class _InputWordScreenState extends State<InputWordScreen> {
  final _wordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isCorrectInput = false;
  bool showRightAnswer = false;

  void _checkInput() {
    if (!_formKey.currentState!.validate()) return;
    showRightAnswer = true;
    if (_wordController.text == widget.trainingInfo.word.word) {
      isCorrectInput = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter word screen'),
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
                  widget.trainingInfo.word.results[0].definition,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: showRightAnswer
                  ? _correctAnswer()
                  : Form(
                      key: _formKey,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        controller: _wordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          filled: true,
                          // fillColor: Colors.white70,
                          hintText: 'Enter here',
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                          ),
                          errorStyle: const TextStyle(
                            // color: Color.fromARGB(255, 165, 24, 14),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please, input word';
                          }
                          return null;
                        },
                      ),
                    ),
            ),
            !showRightAnswer
                ? SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _checkInput,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      child: const Text(
                        'Check',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ResultScreen.routeName,
                          arguments: TrainingInfo(
                            word: widget.trainingInfo.word,
                            quizChosenAnswer:
                                widget.trainingInfo.quizChosenAnswer,
                            inputWordTypedAnswer: _wordController.text,
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _correctAnswer() {
    return isCorrectInput
        ? Text(
            _wordController.text,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        : Column(
            children: [
              Text(
                _wordController.text,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                widget.trainingInfo.word.word,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
  }
}
