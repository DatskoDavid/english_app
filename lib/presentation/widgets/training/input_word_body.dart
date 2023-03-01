import 'package:flutter/material.dart';

import '../../../data/get_word_service.dart';
import 'next_btn.dart';
import 'question_card.dart';

class InputWordBody extends StatefulWidget {
  static const routeName = '/input_word';

  final WordApi wordApi;

  InputWordBody({super.key, required this.wordApi});

  @override
  State<InputWordBody> createState() => _InputWordBodyState();
}

class _InputWordBodyState extends State<InputWordBody> {
  final _wordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isCorrectInput = false;
  bool showRightAnswer = false;

  void _checkInput() {
    if (!_formKey.currentState!.validate()) return;
    showRightAnswer = true;
    if (_wordController.text == widget.wordApi.word) {
      isCorrectInput = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          QuestionCard(definition: widget.wordApi.results[0].definition),
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
                      backgroundColor: MaterialStateProperty.all(Colors.green),
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
              : NextBtn(handler: () {})
        ],
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
                widget.wordApi.word,
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
