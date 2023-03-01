import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultsBody extends StatelessWidget {
  const ResultsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Results',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30.0,
            ),
          ),
          const SizedBox(height: 30),
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 13.0,
            animation: true,
            percent: 1,
            header: const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              /* child: Text(
                      trainingInfo.word.word,
                      style: const TextStyle(
                          // color: Colors.indigo,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ), */
            ),
            center: const Text(
              '100%',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 25.0,
              ),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
