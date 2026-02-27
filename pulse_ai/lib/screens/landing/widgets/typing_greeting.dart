import 'dart:async';
import 'package:flutter/material.dart';

class TypingGreeting extends StatefulWidget {
  final String text;

  const TypingGreeting({super.key, required this.text});

  @override
  State<TypingGreeting> createState() => _TypingGreetingState();
}

class _TypingGreetingState extends State<TypingGreeting> {
  String _displayedText = "";
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      if (_index < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_index];
          _index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      textAlign: TextAlign.center,
      style: Theme.of(
        context,
      ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
