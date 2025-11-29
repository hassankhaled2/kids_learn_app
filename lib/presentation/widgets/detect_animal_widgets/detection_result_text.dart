import 'package:flutter/material.dart';

class DetectionResultText extends StatelessWidget {
  final String result;

  const DetectionResultText({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      result,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}