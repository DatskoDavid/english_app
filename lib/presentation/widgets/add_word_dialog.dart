import 'package:flutter/material.dart';
import '../../data/get_word_service.dart';

class AddWordDialog extends StatefulWidget {
  AddWordDialog({Key? key}) : super(key: key);

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _wordController = TextEditingController();

  bool wordIsCorrect = true;
  String incorrectWord = '';

  Future checkWord(String word) async {
    final wordService = WordService(word);
    // ignore: unused_local_variable
    final response = await wordService.fetchWords().then(
      (value) {
        wordIsCorrect = true;
      },
    ).onError(
      (error, stackTrace) {
        wordIsCorrect = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input word'),
      content: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: TextFormField(
          controller: _wordController,
          onChanged: (value) {
            if (!wordIsCorrect && incorrectWord != value) {
              wordIsCorrect = true;
            }
          },
          decoration: InputDecoration(
            hintText: 'Enter here...',
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            } else if (!value.contains(RegExp(r'^[a-z]+$'))) {
              return 'Word must contain only letters';
            } else if (!wordIsCorrect) {
              incorrectWord = value;
              return 'Word is incorrect';
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
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
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
            onPressed: () async {
              await checkWord(_wordController.text);
              if (_formKey.currentState!.validate()) {
                //TODO: make validation via network
                /* final box = Hive.box<Word>('words_box');
                box.add(
                  Word(
                      id: DateTime.now().toString(),
                      word: _wordController.text),
                ); */
                Navigator.pop(context);
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
