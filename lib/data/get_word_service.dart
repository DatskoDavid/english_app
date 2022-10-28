import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class WordApi {
  final String word;
  final String pronunciation;
  final List<Result> results;

  WordApi({
    required this.word,
    required this.pronunciation,
    required this.results,
  });

  factory WordApi.fromJson(Map<String, dynamic> json) {
    final allPronunciations = json['pronunciation'];

    final resultsJson = json['results'] as List;

    final resultsList =
        resultsJson.map(((item) => Result.fromJson(item))).toList();

    final checkWord = json['word'] as String;
    log(checkWord);

    return WordApi(
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

  then(Null Function(dynamic value) param0) {}
}

class Result {
  final String partOfSpeech;
  final String definition;
  // final List<String?> examples;

  Result({
    required this.partOfSpeech,
    required this.definition,
    // required this.examples,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    /* final examplesJson = json['examples'];
    final examplesList = examplesJson.cast<String>() as List; */

    return Result(
      partOfSpeech: json['partOfSpeech'] as String,
      definition: json['definition'] as String,
      // examples: examplesList,
    );
  }

  Map<String, dynamic> toJson() => {
        'partOfSpeech': partOfSpeech,
        'definition': definition,
        //'example': examples,
      };
}

class WordService {
  final String word;

  WordService(this.word);

  Future<WordApi> fetchWords() async {
    const baseUrl = 'https://wordsapiv1.p.rapidapi.com/words/';
    final requestUrl = baseUrl + word;

    final response = await http.get(
      Uri.parse(requestUrl),
      headers: {
        'X-RapidAPI-Key': '72d92e3a98mshcc5811077a6c5c2p1d4945jsn76d2c4b4e5fd',
        'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com'
      },
    );

    if (response.statusCode == 200) {
      return WordApi.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
