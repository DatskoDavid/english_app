import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../domain/models/training_info.dart';
import '../home_screen.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = 'result';

  final TrainingInfo trainingInfo;

  const ResultScreen({super.key, required this.trainingInfo});

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
            const SizedBox(
              height: 30,
            ),
            CircularPercentIndicator(
              radius: 70.0,
              lineWidth: 13.0,
              animation: true,
              percent: trainingInfo.percent / 100,
              header: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  trainingInfo.word.word,
                  style: const TextStyle(
                      // color: Colors.indigo,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              center: Text(
                '${trainingInfo.percent.round()}%',
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
                margin:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 50),
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
                        trainingInfo.isCorrectQuizAnswer
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
                        trainingInfo.isCorrectInputWordAnswer
                            ? _answerIcon(Icons.check)
                            : _answerIcon(Icons.close)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
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
