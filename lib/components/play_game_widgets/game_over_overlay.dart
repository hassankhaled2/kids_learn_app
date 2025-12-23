

import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../constants/custom_elevated_button.dart';
import '../../constants/spacing.dart';



class GameOverOverlay extends StatelessWidget {
  final int score;
  final VoidCallback onRestartGame;
  const GameOverOverlay({
    super.key,
    required this.score,
    required this.onRestartGame,
  });

  String _getResultMessage() {
    // Assuming a perfect score is 10 items * 10 points = 100
    if (score == 100) {
      return AppStrings.awesomeText;
    } else {
      return AppStrings.playAgaintogetbetterScoreText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Text(
            AppStrings.gameOverText,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(10),
          Text(
            _getResultMessage(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey.shade500,
            ),
          ),
          verticalSpace(30),
          customElevatedButton(text:  AppStrings.newGameText, onPressed:onRestartGame )

        ],
      ),
    );
  }
}