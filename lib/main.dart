import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'client/hive_names.dart';
import 'data/get_word_service.dart';
import 'domain/models/hive/word.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/training_mode_screens/input_word_screen.dart';
import 'presentation/screens/training_mode_screens/quiz_screen.dart';
import 'presentation/screens/training_mode_screens/result_screen.dart';
import 'presentation/screens/vocabulary_screen.dart';
import 'presentation/screens/word_info_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<Word>('words_box');
  runApp(const MyApp());
}

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
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        VocabularyScreen.routeName: (context) => const VocabularyScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == WordInfoScreen.routeName) {
          final word = (settings.arguments ??
              Hive.box<Word>(BoxNames.words).getAt(0)?.word) as String;

          return MaterialPageRoute(
            builder: (context) => WordInfoScreen(word: word),
          );
        } else if (settings.name == QuizScreen.routeName) {
          final word = settings.arguments as WordApi;

          return MaterialPageRoute(
            builder: (context) => QuizScreen(word: word),
          );
        } else if (settings.name == InputWordScreen.routeName) {
          final word = settings.arguments as WordApi;

          return MaterialPageRoute(
            builder: (context) => InputWordScreen(word: word),
          );
        } else if (settings.name == ResultScreen.routeName) {
          final word = settings.arguments as WordApi;

          return MaterialPageRoute(
            builder: (context) => ResultScreen(word: word),
          );
        }

        assert(false, 'Need to implement: ${settings.name}');
        return null;
      },
    );
  }
}
