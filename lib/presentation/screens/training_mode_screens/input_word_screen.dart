import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../blocs/quiz_bloc/quiz_event.dart';
import '../../blocs/quiz_bloc/quiz_state.dart';
import '../../di/injector.dart';
import '../../widgets/training/question_card.dart';
import 'result_screen.dart';

class InputWordScreen extends StatefulWidget {
  static const routeName = '/input_word';

  // final TrainingInfo trainingInfo;

  // InputWordScreen({super.key, required this.trainingInfo});

  @override
  State<InputWordScreen> createState() => _InputWordScreenState();
}

class _InputWordScreenState extends State<InputWordScreen> {
  late QuizBloc _bloc;

  final _wordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  /* bool isCorrectInput = false;
  bool showRightAnswer = false; */

  /* void _checkInput() {
    if (!_formKey.currentState!.validate()) return;
    showRightAnswer = true;
    if (_wordController.text == widget.trainingInfo.word.word) {
      isCorrectInput = true;
    }
    setState(() {});
  } */

  @override
  void initState() {
    _bloc = i.get<QuizBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter word screen'),
      ),
      body: Center(
        child: BlocBuilder<QuizBloc, QuizState>(
          bloc: _bloc,
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                QuestionCard(
                  // definition: widget.trainingInfo.word.results[0].definition,
                  definition: state.trainingInfo!.word.results.first.definition,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: state.isEnterdWord
                      ? _correctAnswer(state.trainingInfo!.word.word,
                          state.trainingInfo!.isCorrectInputWordAnswer)
                      : Form(
                          key: _formKey,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                !state.isEnterdWord
                    ? SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          // onPressed: _checkInput,
                          onPressed: () => _bloc.add(
                            CheckEnteredWord(enteredWord: _wordController.text),
                          ),
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
            );
          },
        ),
      ),
    );
  }

  Widget _correctAnswer(String word, bool isCorrectInput) {
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
                word,
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
