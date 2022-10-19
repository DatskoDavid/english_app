import 'package:flutter/material.dart';

import 'training_mode_screens/quiz_screen.dart';

class WordInfoScreen extends StatelessWidget {
  final String word;

  const WordInfoScreen({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training mode screen'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset('assets/images/balancing-stones.jpg'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        word,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const IconButton(
                      icon: Icon(Icons.volume_up_outlined),
                      onPressed: null,
                    ),
                  ],
                ),
                const Text(
                  'transcription',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const ListTile(
            leading: CircleAvatar(child: Text('verb')),
            title: Text('meaning'),
            subtitle: Text('example'),
          ),
          const ListTile(
            leading: CircleAvatar(child: Text('verb')),
            title: Text('meaning'),
            subtitle: Text('example'),
          ),
          const ListTile(
            leading: CircleAvatar(child: Text('verb')),
            title: Text('meaning'),
            subtitle: Text('example'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return const QuizScreen();
                    },
                  ),
                );
              },
              child: const Text('Next'))
        ],
      ),
    );
  }
}
