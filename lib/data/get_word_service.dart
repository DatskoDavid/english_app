import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Word {
  final String word;
  final String pronunciation;
  final List<Result> results;

  Word({
    required this.word,
    required this.pronunciation,
    required this.results,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    final allPronunciations = json['pronunciation'];

    final resultsJson = json['results'] as List;

    final resultsList =
        resultsJson.map(((item) => Result.fromJson(item))).toList();

    final checkWord = json['word'] as String;
    log(checkWord);

    return Word(
      word: json['word'] as String,
      pronunciation: allPronunciations['all'] as String,
      results: resultsList,
    );
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'pronunciation': pronunciation,
        'results': results,
      };
}

class Result {
  final String partOfSpeech;
  final String definition;
  // final List<String> examples;

  // TO DO: convert example to list
  // final String example;

  Result({
    required this.partOfSpeech,
    required this.definition,
    // required this.examples,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    /* final examplesJson = json['examples'];
    final examplesList = examplesJson.cast<String>() ?? ['null'];
 */
    return Result(
      partOfSpeech: json['partOfSpeech'] as String,
      definition: json['definition'] as String,
      // examples: json['examples'] as List<String>,
      // examples: examplesList,
      //examples: examplesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'partOfSpeech': partOfSpeech,
        'definition': definition,
        //'example': examples,
      };
}

/* class Example {
  final String example;

  Example({required this.example});

  factory Example.fromJson(String exmpl) {
    return Example(example: exmpl);
  }
} */

Future<Word> fetchWords() async {
  const url = 'https://wordsapiv1.p.rapidapi.com/words/example';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'X-RapidAPI-Key': '72d92e3a98mshcc5811077a6c5c2p1d4945jsn76d2c4b4e5fd',
      'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com'
    },
  );

  if (response.statusCode == 200) {
    return Word.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}


/* const options = {
  method: 'GET',
  url: 'https://wordsapiv1.p.rapidapi.com/words/%7Bword%7D',
  headers: {
    'X-RapidAPI-Key': '72d92e3a98mshcc5811077a6c5c2p1d4945jsn76d2c4b4e5fd',
    'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com'
  }
}; */