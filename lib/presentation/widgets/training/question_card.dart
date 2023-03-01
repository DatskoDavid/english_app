import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key, required this.definition}) : super(key: key);

  final String definition;

  @override
  Widget build(BuildContext context) {
    return Center(
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
          definition,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
