import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'domain/models/word.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WordAdapter());
  await Hive.openBox<Word>('words_box');
  //final box = Hive.box<Word>('words_box');
  /* box.add(Word(id: '0', word: 'consume', isFavourite: true));
  box.add(Word(id: '1', word: 'aware', isFavourite: false));
  box.add(Word(id: '2', word: 'maintain', isFavourite: true)); */
  // box.clear();
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
        /*  appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
        ), */
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
