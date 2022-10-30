import 'package:flutter/material.dart';

import '../home_screen.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = 'result';

  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ResultScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your progress in learn of ___ word',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 30,
            ),
            CircularProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.grey[400],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.home),
        onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
      ),
    );
  }
}
