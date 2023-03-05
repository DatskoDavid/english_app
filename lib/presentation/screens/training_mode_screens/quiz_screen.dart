import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/get_word_service.dart';
import '../../../domain/models/training_info.dart';
import '../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../blocs/quiz_bloc/quiz_event.dart';
import '../../blocs/quiz_bloc/quiz_state.dart';
import '../../di/injector.dart';
import '../../widgets/next_screen_btn.dart';
import '../../widgets/quiz_variant.dart';
import 'input_word_screen.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';

  final WordApi word;

  QuizScreen({super.key, required this.word});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // late final currentTrainingInfo = TrainingInfo(word: widget.word);
  late final QuizBloc _bloc;

  @override
  void initState() {
    // generateRandomVariants();
    _bloc = i.get<QuizBloc>()..add(InitVariants(widget.word.word));
    super.initState();
  }

  // bool isChoosedAnswer = false;

  //TODO: return to generation
  /* List<String> variants = <String>[
    /* 'assume',
    'permit',
    'admit',
    'persuade', */
  ]; */

  // bool isCorrect(String variant) => variant == widget.word.word;

  void showRightAnswer(String choosedAnswer) {
    // trainingInfo = trainingInfo.copyWith(quizChosenAnswer: choosedAnswer);

    /*  setState(() {
      isChoosedAnswer = true;
    }); */
  }

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
                  color: Colors.lightBlue[100],
                  border: Border.all(
                    color: const Color.fromARGB(255, 100, 190, 103),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.word.results[0].definition,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<QuizBloc, QuizState>(
              bloc: _bloc,
              builder: (context, state) {
                // final trainingInfoTempList = <TrainingInfo>[];
                // trainingInfoTempList.add(currentTrainingInfo);

                //state.copyWith(trainingInfoList: trainingInfoTempList);

                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    /* final trainingInfoTempList = <TrainingInfo>[];

                    for (var i = 0; i < state.variants.length; i++) {
                      final trainingInfo = TrainingInfo(word: widget.word);
                      trainingInfoTempList.add(trainingInfo);
                    }

                    state.copyWith(trainingInfoList: trainingInfoTempList); */

                    return QuizVariant(
                      variant: state.variants[index],
                      // isCorrect: isCorrect(state.variants[index]),
                      isCorrect: state.trainingInfo?.word.word ==
                          state.variants[index],
                      // onTapHandler: state.isChoosedAnswer ? () {} : showRightAnswer,
                      onTapHandler: () => _bloc.add(
                        OnVariantTap(
                          choosedVariant: state.variants[index],
                          // trainingInfo: currentTrainingInfo,
                        ),
                      ),
                      showCorrectAnswer: state.isChoosedAnswer,
                    );
                    /* return QuizVariant(
                      variant: variants[index],
                      isCorrect: isCorrect(variants[index]),
                      onTapHandler: isChoosedAnswer ? () {} : showRightAnswer,
                      showCorrectAnswer: isChoosedAnswer,
                    ); */
                  },
                  itemCount: state.variants.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                );
              },
            ),
            const SizedBox(height: 20),
            NextScreenBtn(
              routeName: InputWordScreen.routeName,
              // arguments: currentTrainingInfo,
            ),
          ],
        ),
      ),
    );
  }
}
