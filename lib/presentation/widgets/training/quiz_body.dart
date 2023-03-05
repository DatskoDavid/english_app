import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/get_word_service.dart';
import '../../../domain/models/training_info.dart';
import '../../blocs/quiz_bloc/quiz_bloc.dart';
import '../../blocs/quiz_bloc/quiz_event.dart';
import '../../blocs/quiz_bloc/quiz_state.dart';
import '../../di/injector.dart';
import '../quiz_variant.dart';
import 'next_btn.dart';
import 'question_card.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({Key? key, required this.wordApi}) : super(key: key);

  final WordApi wordApi;

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  late TrainingInfo trainingInfo = TrainingInfo(word: widget.wordApi);
  late final QuizBloc _bloc;
  bool isChoosedAnswer = false;

  bool isCorrect(String variant) => variant == widget.wordApi.word;

  void showRightAnswer(String choosedAnswer) {
    trainingInfo = trainingInfo.copyWith(quizChosenAnswer: choosedAnswer);

    setState(() {
      isChoosedAnswer = true;
    });
  }

  @override
  void initState() {
    _bloc = i.get<QuizBloc>()..add(InitVariants(widget.wordApi.word));
    super.initState();
  }

  /* @override
  void dispose() {
    isChoosedAnswer = false;
    _bloc.close();
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        QuestionCard(definition: widget.wordApi.results[0].definition),
        const SizedBox(height: 20),
        BlocBuilder<QuizBloc, QuizState>(
          bloc: _bloc,
          builder: (context, state) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return QuizVariant(
                  variant: state.variants[index],
                  isCorrect: isCorrect(state.variants[index]),
                  onTapHandler: isChoosedAnswer ? () {} : showRightAnswer,
                  showCorrectAnswer: isChoosedAnswer,
                );
              },
              itemCount: state.variants.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          },
        ),
        const SizedBox(height: 20),
        NextBtn(handler: () {}),
      ],
    );
  }
}
