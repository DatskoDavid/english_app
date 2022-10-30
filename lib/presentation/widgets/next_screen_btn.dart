import 'package:flutter/material.dart';

class NextScreenBtn extends StatelessWidget {
  final String routeName;
  final Object? arguments;

  NextScreenBtn({
    required this.routeName,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(
          context,
          routeName,
          arguments: arguments,
        ),
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
