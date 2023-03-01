import 'package:flutter/material.dart';

class NextBtn extends StatelessWidget {
  final Function handler;

  NextBtn({required this.handler});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => handler(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
