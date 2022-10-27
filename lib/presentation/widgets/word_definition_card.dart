import 'package:flutter/material.dart';

import '../../data/get_word_service.dart';

class WordDefinitionCard extends StatelessWidget {
  final Result result;

  const WordDefinitionCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          /* constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.2), */
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Text(
            result.partOfSpeech,
            style: const TextStyle(
              color: Colors.indigo,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        title: Text(result.definition),
        subtitle: const Text('example'),
      ),
    );
  }
}
