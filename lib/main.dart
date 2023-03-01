import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/data_sources/database_data_sources.dart';
import 'data/get_word_service.dart';
import 'domain/models/training_info.dart';
import 'presentation/di/injector.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/training_mode_screens/input_word_screen.dart';
import 'presentation/screens/training_mode_screens/quiz_screen.dart';
import 'presentation/screens/training_mode_screens/result_screen.dart';
import 'presentation/screens/true_training_mode/training_controller.dart';
import 'presentation/screens/vocabulary_screen.dart';
import 'presentation/screens/word_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseDataSource.initializeHive();
  initInjector();
  runApp(const MyApp());
}

//TODO: Make dependency injection

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() async {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English words',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        useMaterial3: true,
      ),
      initialRoute: HomeScreen.routeName,
      // initialRoute: TrainingController.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        VocabularyScreen.routeName: (context) => const VocabularyScreen(),
      },
      onGenerateRoute: (settings) {
        //ToDo: refactor it to switch/case

        if (settings.name == WordInfoScreen.routeName) {
          //TODO: remake to get word via use case
          /*  final word = (settings.arguments ??
              Hive.box<Word>(BoxNames.words).getAt(0)?.word) as String; */

          final word = (settings.arguments ?? 'null') as String;

          return MaterialPageRoute(
            builder: (context) => WordInfoScreen(word: word),
          );
        } else if (settings.name == QuizScreen.routeName) {
          final word = settings.arguments as WordApi;

          return MaterialPageRoute(
            builder: (context) => QuizScreen(word: word),
          );
        } else if (settings.name == InputWordScreen.routeName) {
          final trainingInformation = settings.arguments as TrainingInfo;

          return MaterialPageRoute(
            builder: (context) =>
                InputWordScreen(trainingInfo: trainingInformation),
          );
        } else if (settings.name == ResultScreen.routeName) {
          final trainingInformation = settings.arguments as TrainingInfo;

          return MaterialPageRoute(
            builder: (context) =>
                ResultScreen(trainingInfo: trainingInformation),
          );
        } else if (settings.name == TrainingController.routeName) {
          return MaterialPageRoute(
            builder: (context) => TrainingController(),
          );
        }

        assert(false, 'Need to implement: ${settings.name}');
        return null;
      },
    );
  }
}
