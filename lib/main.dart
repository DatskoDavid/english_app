import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
        //WordInfoScreen.routeName: (context) => WordInfoScreen(),
        QuizScreen.routeName: (context) => QuizScreen(),
        InputWordScreen.routeName: (context) => InputWordScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == WordInfoScreen.routeName) {
          final word = ModalRoute.of(context)!.settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => WordInfoScreen(word: word),
          );
        }

        assert(false, 'Need to implement: ${settings.name}');
        return null;
      },
    );
  }
}
