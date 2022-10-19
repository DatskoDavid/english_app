import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/models/word.dart';

class AddWordDialog extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _wordController = TextEditingController();

  AddWordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input word'),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: TextFormField(
          controller: _wordController,
          decoration: InputDecoration(
            hintText: 'Enter here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            } else {
              return null;
            }
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: OutlinedButton(
            style: ButtonStyle(
              /* backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 66, 143, 68),
                  ), */
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              Future.delayed(
                const Duration(milliseconds: 500),
                () {
                  _wordController.clear();
                },
              );
              Navigator.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 18, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 66, 143, 68),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final box = Hive.box<Word>('words_box');
                box.add(
                  Word(
                      id: DateTime.now().toString(),
                      word: _wordController.text),
                );
                Future.delayed(
                  const Duration(milliseconds: 50),
                  () {
                    _wordController.clear();
                  },
                );
                Navigator.of(context).pop();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
