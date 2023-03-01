import 'package:flutter/material.dart';

import '../../../data/get_word_service.dart';
import '../../../domain/models/training_info.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/training/input_word_body.dart';
import '../../widgets/training/next_btn.dart';
import '../../widgets/training/quiz_body.dart';
import '../../widgets/training/results_body.dart';

class TrainingController extends StatefulWidget {
  TrainingController({Key? key}) : super(key: key);

  static const routeName = '/trainingController';

  @override
  State<TrainingController> createState() => _TrainingControllerState();
}

class _TrainingControllerState extends State<TrainingController> {
  final words = <String>['hand', 'permit', 'ball'];

  final traininginfoList = <TrainingInfo>[
    TrainingInfo(word: wordsApi[0]),
    TrainingInfo(word: wordsApi[1]),
    TrainingInfo(word: wordsApi[2]),
  ];

  final questions = <Widget>[
    QuizBody(wordApi: wordsApi[0], key: UniqueKey()),
    QuizBody(wordApi: wordsApi[1], key: UniqueKey()),
    QuizBody(wordApi: wordsApi[2], key: UniqueKey()),
    InputWordBody(wordApi: wordsApi[0], key: UniqueKey()),
    InputWordBody(wordApi: wordsApi[1], key: UniqueKey()),
    InputWordBody(wordApi: wordsApi[2], key: UniqueKey()),
    const ResultsBody(),
  ];

  bool _startTraining = false;
  int _questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_startTraining
          ? Center(
              child: ElevatedButton(
                onPressed: () => {
                  setState(() {
                    _startTraining = true;
                  }),
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 63, 151, 66)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: Text(
                    'Start',
                    style: AppTextStyles.kWhiteButtonStyle,
                  ),
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(height: 400, child: questions[_questionNumber]),
                NextBtn(
                  handler: () => setState(
                    () {
                      if (_questionNumber < questions.length - 1) {
                        _questionNumber++;
                      } else {
                        _startTraining = false;
                        _questionNumber = 0;
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

// TODO: delete fake data
final wordsApi = <WordApi>[
  WordApi(
    word: 'hand',
    pronunciation: 'wo:d',
    results: [
      Result(
        partOfSpeech: 'noun',
        definition: 'last part of arm',
      ),
    ],
  ),
  WordApi(
    word: 'permit',
    pronunciation: 'pemit',
    results: [
      Result(
        partOfSpeech: 'verb',
        definition: 'allow sb to do sth',
      ),
    ],
  ),
  WordApi(
    word: 'ball',
    pronunciation: 'bal:',
    results: [
      Result(
        partOfSpeech: 'noun',
        definition: 'circle thing to play football',
      ),
    ],
  )
];
