import 'package:flutter/material.dart';

class QuizVariant extends StatefulWidget {
  final String variant;
  final bool isCorrect;
  final Function onTapHandler;
  bool showCorrectAnswer;

  QuizVariant({
    super.key,
    required this.variant,
    required this.isCorrect,
    required this.onTapHandler,
    required this.showCorrectAnswer,
  });

  @override
  State<QuizVariant> createState() => _QuizVariantState();
}

class _QuizVariantState extends State<QuizVariant> {
  bool isPressed = false;

  Color getColor() {
    if (widget.isCorrect && isPressed ||
        widget.isCorrect && widget.showCorrectAnswer) {
      return Colors.green;
    } else if (isPressed && !widget.isCorrect) {
      return const Color.fromARGB(255, 165, 24, 14);
    }

    return const Color.fromARGB(255, 219, 220, 221);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          splashColor: const Color.fromARGB(255, 131, 118, 118),
          onTap: (() {
            isPressed = true;
            widget.onTapHandler(widget.variant);
          }),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.variant,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
