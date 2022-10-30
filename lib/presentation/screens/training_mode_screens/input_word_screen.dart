import 'package:flutter/material.dart';

import '../../../data/get_word_service.dart';
import '../../widgets/next_screen_btn.dart';
import 'result_screen.dart';

class InputWordScreen extends StatelessWidget {
  static const routeName = 'input_word';

  @override
  Widget build(BuildContext context) {
    final word = ModalRoute.of(context)!.settings.arguments as Future<WordApi>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter word screen'),
      ),
      body: Center(
        child: FutureBuilder<WordApi>(
          future: word,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 100, 190, 103),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      snapshot.data!.results[0].definition,
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        // fillColor: Colors.white70,
                        hintText: 'Enter here',
                        hintStyle: TextStyle(color: Colors.grey[800])),
                  ),
                ),
                NextScreenBtn(
                  routeName: ResultScreen.routeName,
                  arguments: word,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
