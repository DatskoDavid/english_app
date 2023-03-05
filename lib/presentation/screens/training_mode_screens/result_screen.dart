import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../blocs/quiz_bloc/quiz_state.dart';
import '../../di/injector.dart';
import '../home_screen.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result';

  late final _bloc = i.get<QuizBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultScreen'),
      ),
      body: Center(
        child: BlocBuilder<QuizBloc, QuizState>(
          bloc: _bloc,
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your progress in learn of word',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                CircularPercentIndicator(
                  radius: 70.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: state.trainingInfo!.percent / 100,
                  header: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      state.trainingInfo!.word.word,
                      style: const TextStyle(
                          // color: Colors.indigo,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  center: Text(
                    '${state.trainingInfo!.percent.round()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 50),
                    padding: const EdgeInsets.all(10),
                    // height: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 220, 221),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Quiz Mode:  ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            state.trainingInfo!.isCorrectQuizAnswer
                                ? _answerIcon(Icons.check)
                                : _answerIcon(Icons.close)
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Input Word Mode:  ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            state.trainingInfo!.isCorrectInputWordAnswer
                                ? _answerIcon(Icons.check)
                                : _answerIcon(Icons.close)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (r) => false,
        ),
        // onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
      ),
    );
  }

  Widget _answerIcon(
    IconData icon,
  ) {
    return Container(
      child: Icon(icon, color: const Color(0xffffffff), size: 20.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: icon == Icons.check ? Colors.green : Colors.red,
        borderRadius: const BorderRadius.all(
          Radius.circular(100.0),
        ),
      ),
    );
  }
}
